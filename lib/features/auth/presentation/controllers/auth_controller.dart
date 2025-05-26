import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/usecases/auth_usecases.dart';
import '../../data/datasources/auth_local_datasource.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final User? user;
  final String? errorMessage;
  final String? accessToken;
  final String? refreshToken;
  final bool isInitialized;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.errorMessage,
    this.accessToken,
    this.refreshToken,
    this.isInitialized = false,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    User? user,
    String? errorMessage,
    String? accessToken,
    String? refreshToken,
    bool? isInitialized,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;
  final LogoutUseCase _logoutUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final PasswordResetRequestUseCase _passwordResetRequestUseCase;
  final PasswordResetConfirmUseCase _passwordResetConfirmUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final GoogleLoginUseCase _googleLoginUseCase;
  final KakaoLoginUseCase _kakaoLoginUseCase;
  final NaverLoginUseCase _naverLoginUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final AuthLocalDataSource _localDataSource;

  // 중복 실행 방지 플래그
  bool _isCheckingAuth = false;

  AuthController({
    required LoginUseCase loginUseCase,
    required SignUpUseCase signUpUseCase,
    required LogoutUseCase logoutUseCase,
    required RefreshTokenUseCase refreshTokenUseCase,
    required PasswordResetRequestUseCase passwordResetRequestUseCase,
    required PasswordResetConfirmUseCase passwordResetConfirmUseCase,
    required ChangePasswordUseCase changePasswordUseCase,
    required GoogleLoginUseCase googleLoginUseCase,
    required KakaoLoginUseCase kakaoLoginUseCase,
    required NaverLoginUseCase naverLoginUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required AuthLocalDataSource localDataSource,
  }) : _loginUseCase = loginUseCase,
       _signUpUseCase = signUpUseCase,
       _logoutUseCase = logoutUseCase,
       _refreshTokenUseCase = refreshTokenUseCase,
       _passwordResetRequestUseCase = passwordResetRequestUseCase,
       _passwordResetConfirmUseCase = passwordResetConfirmUseCase,
       _changePasswordUseCase = changePasswordUseCase,
       _googleLoginUseCase = googleLoginUseCase,
       _kakaoLoginUseCase = kakaoLoginUseCase,
       _naverLoginUseCase = naverLoginUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       _localDataSource = localDataSource,
       super(const AuthState());

  // 앱 시작 시 자동 로그인 체크 - 중복 실행 방지
  Future<void> checkAuthStatus() async {
    if (_isCheckingAuth) {
      debugPrint('⚠️ 이미 인증 체크 중 - 건너뛰기');
      return;
    }

    _isCheckingAuth = true;
    debugPrint('🔍 자동 로그인 체크 시작');

    try {
      // 저장된 토큰 확인
      final accessToken = await _localDataSource.getAccessToken();
      final refreshToken = await _localDataSource.getRefreshToken();

      if (accessToken != null && refreshToken != null) {
        debugPrint('✅ 저장된 토큰 발견 - 사용자 정보 확인 중');

        // 현재 사용자 정보 가져오기 시도
        final result = await _getCurrentUserUseCase.call();

        result.fold(
          (failure) async {
            debugPrint('❌ 토큰으로 사용자 정보 조회 실패 - 토큰 갱신 시도');
            debugPrint('   실패 이유: ${failure.toString()}');

            // 토큰 갱신 시도
            final refreshResult = await _refreshTokenUseCase.call(
              RefreshTokenParams(refreshToken: refreshToken),
            );

            refreshResult.fold(
              (refreshFailure) {
                debugPrint('❌ 토큰 갱신 실패: ${refreshFailure.toString()}');
                _clearAuthData();
              },
              (newToken) async {
                debugPrint('✅ 토큰 갱신 성공');

                // 새 토큰 저장
                await _localDataSource.saveTokens(
                  accessToken: newToken.accessToken,
                  refreshToken: newToken.refreshToken,
                );

                // 새 토큰으로 사용자 정보 재조회
                final userResult = await _getCurrentUserUseCase.call();
                userResult.fold(
                  (userFailure) {
                    debugPrint(
                      '❌ 토큰 갱신 후에도 사용자 정보 조회 실패: ${userFailure.toString()}',
                    );
                    // 토큰은 유효하므로 기본 사용자 정보로 설정
                    _setAuthenticatedWithoutUser(
                      newToken.accessToken,
                      newToken.refreshToken,
                    );
                  },
                  (user) {
                    debugPrint('✅ 자동 로그인 성공: ${user.username}');
                    state = state.copyWith(
                      isAuthenticated: true,
                      user: user,
                      accessToken: newToken.accessToken,
                      refreshToken: newToken.refreshToken,
                      isInitialized: true,
                    );
                  },
                );
              },
            );
          },
          (user) {
            debugPrint('✅ 자동 로그인 성공: ${user.username}');
            state = state.copyWith(
              isAuthenticated: true,
              user: user,
              accessToken: accessToken,
              refreshToken: refreshToken,
              isInitialized: true,
            );
          },
        );
      } else {
        debugPrint('ℹ️ 저장된 토큰 없음 - 로그인 필요');
        state = state.copyWith(isInitialized: true);
      }
    } catch (e) {
      debugPrint('❌ 자동 로그인 체크 중 오류: $e');
      state = state.copyWith(isInitialized: true);
    } finally {
      _isCheckingAuth = false;
    }
  }

  // 사용자 정보 없이 인증된 상태로 설정 (토큰은 유효하지만 사용자 정보 조회 실패 시)
  void _setAuthenticatedWithoutUser(String accessToken, String refreshToken) {
    debugPrint('⚠️ 사용자 정보 없이 인증 상태 설정 (토큰 유지)');
    state = state.copyWith(
      isAuthenticated: true,
      user: null, // 사용자 정보는 나중에 다시 조회 시도
      accessToken: accessToken,
      refreshToken: refreshToken,
      isInitialized: true,
    );
  }

  Future<void> signInWithUsername({
    required String username,
    required String password,
  }) async {
    debugPrint('🔄 로그인 시작: $username');
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _loginUseCase(
      LoginParams(username: username, password: password),
    );

    result.fold(
      (failure) {
        debugPrint('❌ 로그인 실패: ${failure.toString()}');
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getErrorMessage(failure),
          isAuthenticated: false,
        );
      },
      (authResponse) {
        debugPrint('✅ 로그인 성공!');
        debugPrint('🔑 토큰 정보: ${authResponse.accessToken.substring(0, 20)}...');
        debugPrint(
          '👤 유저 정보: ${authResponse.user.username}, ${authResponse.user.email}, ${authResponse.user.role}',
        );
        debugPrint('📛 유저 이름: ${authResponse.user.profile.name}');

        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          user: authResponse.user,
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
          errorMessage: null,
        );

        debugPrint('🎯 로그인 성공 - /questions로 이동해야 함');
      },
    );
  }

  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _signUpUseCase(
      SignUpParams(
        username: name,
        email: email,
        password: password,
        confirmPassword: password,
      ),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getErrorMessage(failure),
          isAuthenticated: false,
        );
      },
      (user) {
        debugPrint('✅ 회원가입 성공: ${user.username}');
        state = state.copyWith(
          isLoading: false,
          user: user,
          errorMessage: null,
        );
      },
    );
  }

  // 비밀번호 재설정 요청
  Future<void> requestPasswordReset(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _passwordResetRequestUseCase(
      PasswordResetRequestParams(email: email),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getErrorMessage(failure),
        );
      },
      (_) {
        debugPrint('✅ 비밀번호 재설정 이메일 발송 성공');
        state = state.copyWith(isLoading: false, errorMessage: null);
      },
    );
  }

  Future<void> signInWithGoogle({String? code, String? redirectUri}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    if (code != null && redirectUri != null) {
      final result = await _googleLoginUseCase(
        GoogleLoginParams(code: code, redirectUri: redirectUri),
      );

      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: _getErrorMessage(failure),
          );
        },
        (authResponse) {
          state = state.copyWith(
            isLoading: false,
            isAuthenticated: true,
            user: authResponse.user,
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
            errorMessage: null,
          );
        },
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            'Google 로그인 URL: https://accounts.google.com/o/oauth2/v2/auth...',
      );
    }
  }

  Future<void> signInWithApple() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Apple Sign-In 미구현
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(
      isLoading: false,
      errorMessage: 'Apple 로그인은 아직 지원하지 않습니다',
    );
  }

  Future<void> signInWithKakao({String? code, String? redirectUri}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    if (code != null && redirectUri != null) {
      final result = await _kakaoLoginUseCase(
        KakaoLoginParams(code: code, redirectUri: redirectUri),
      );

      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: _getErrorMessage(failure),
          );
        },
        (authResponse) {
          state = state.copyWith(
            isLoading: false,
            isAuthenticated: true,
            user: authResponse.user,
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
            errorMessage: null,
          );
        },
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            'Kakao 로그인 URL: https://kauth.kakao.com/oauth/authorize...',
      );
    }
  }

  Future<void> signInWithNaver({
    String? code,
    String? redirectUri,
    String? naverState,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    if (code != null && redirectUri != null && naverState != null) {
      final result = await _naverLoginUseCase(
        NaverLoginParams(
          code: code,
          redirectUri: redirectUri,
          state: naverState,
        ),
      );

      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: _getErrorMessage(failure),
          );
        },
        (authResponse) {
          state = state.copyWith(
            isLoading: false,
            isAuthenticated: true,
            user: authResponse.user,
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
            errorMessage: null,
          );
        },
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            'Naver 로그인 URL: https://nid.naver.com/oauth2.0/authorize...',
      );
    }
  }

  Future<void> signOut() async {
    if (state.refreshToken == null) {
      await _clearAuthData();
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _logoutUseCase(
      LogoutParams(refreshToken: state.refreshToken!),
    );

    // 서버 로그아웃 성공 여부와 관계없이 로컬 상태 초기화
    await _clearAuthData();
  }

  // 로컬 인증 데이터 초기화
  Future<void> _clearAuthData() async {
    await _localDataSource.clearAuthData();
    state = const AuthState(isInitialized: true);
    debugPrint('🧹 인증 데이터 초기화 완료');
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  String _getErrorMessage(dynamic failure) {
    // TODO: failure 타입에 따른 상세한 에러 메시지 처리
    return '요청 처리 중 오류가 발생했습니다. 다시 시도해주세요.';
  }
}
