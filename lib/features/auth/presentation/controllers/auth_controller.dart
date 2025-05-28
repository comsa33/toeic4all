import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/services/google_sign_in_service.dart';
import '../../../../core/services/kakao_sign_in_service.dart';
// import '../../../../core/services/naver_sign_in_service.dart'; // TODO: Naver 로그인 구현 시 활성화
import '../../../../core/services/login_attempt_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/auth_usecases.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../utils/auth_message_handler.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final User? user;
  final String? errorMessage;
  final String? successMessage;
  final String? accessToken;
  final String? refreshToken;
  final bool isInitialized;

  // 소셜 로그인 버튼별 로딩 상태
  final bool isGoogleLoading;
  final bool isKakaoLoading;
  final bool isNaverLoading;
  final bool isAppleLoading;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.errorMessage,
    this.successMessage,
    this.accessToken,
    this.refreshToken,
    this.isInitialized = false,
    this.isGoogleLoading = false,
    this.isKakaoLoading = false,
    this.isNaverLoading = false,
    this.isAppleLoading = false,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    User? user,
    String? errorMessage,
    String? successMessage,
    String? accessToken,
    String? refreshToken,
    bool? isInitialized,
    bool? isGoogleLoading,
    bool? isKakaoLoading,
    bool? isNaverLoading,
    bool? isAppleLoading,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isInitialized: isInitialized ?? this.isInitialized,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      isKakaoLoading: isKakaoLoading ?? this.isKakaoLoading,
      isNaverLoading: isNaverLoading ?? this.isNaverLoading,
      isAppleLoading: isAppleLoading ?? this.isAppleLoading,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;
  final LogoutUseCase _logoutUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final PasswordResetRequestUseCase _passwordResetRequestUseCase;
  // final PasswordResetConfirmUseCase _passwordResetConfirmUseCase; // TODO: 패스워드 리셋 확인 기능 구현 시 사용
  final ChangePasswordUseCase _changePasswordUseCase;
  // final GoogleLoginUseCase _googleLoginUseCase; // TODO: 웹 Google 로그인 구현 시 사용
  final GoogleLoginMobileUseCase _googleLoginMobileUseCase;
  // final KakaoLoginUseCase _kakaoLoginUseCase; // TODO: 웹 Kakao 로그인 구현 시 사용
  final KakaoLoginMobileUseCase _kakaoLoginMobileUseCase;
  // final NaverLoginMobileUseCase _naverLoginMobileUseCase; // TODO: Naver 로그인 구현 시 사용
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final AuthLocalDataSource _localDataSource;
  final GoogleSignInService _googleSignInService;
  final KakaoSignInService _kakaoSignInService;
  // final NaverSignInService _naverSignInService; // TODO: Naver 로그인 구현 시 사용
  final LoginAttemptService _loginAttemptService;
  // final Ref _ref; // TODO: TokenStorage 직접 접근이 필요한 경우 사용

  // 중복 실행 방지 플래그
  bool _isCheckingAuth = false;

  AuthController({
    required LoginUseCase loginUseCase,
    required SignUpUseCase signUpUseCase,
    required LogoutUseCase logoutUseCase,
    required RefreshTokenUseCase refreshTokenUseCase,
    required PasswordResetRequestUseCase passwordResetRequestUseCase,
    // required PasswordResetConfirmUseCase passwordResetConfirmUseCase, // TODO: 패스워드 리셋 확인 기능 구현 시 사용
    required ChangePasswordUseCase changePasswordUseCase,
    // required GoogleLoginUseCase googleLoginUseCase, // TODO: 웹 Google 로그인 구현 시 사용
    required GoogleLoginMobileUseCase googleLoginMobileUseCase,
    // required KakaoLoginUseCase kakaoLoginUseCase, // TODO: 웹 Kakao 로그인 구현 시 사용
    required KakaoLoginMobileUseCase kakaoLoginMobileUseCase,
    // required NaverLoginMobileUseCase naverLoginMobileUseCase, // TODO: Naver 로그인 구현 시 사용
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required AuthLocalDataSource localDataSource,
    required GoogleSignInService googleSignInService,
    required KakaoSignInService kakaoSignInService,
    // required NaverSignInService naverSignInService, // TODO: Naver 로그인 구현 시 사용
    required LoginAttemptService loginAttemptService,
    // required Ref ref, // TODO: TokenStorage 직접 접근이 필요한 경우 사용
  }) : _loginUseCase = loginUseCase,
       _signUpUseCase = signUpUseCase,
       _logoutUseCase = logoutUseCase,
       _refreshTokenUseCase = refreshTokenUseCase,
       _passwordResetRequestUseCase = passwordResetRequestUseCase,
       // _passwordResetConfirmUseCase = passwordResetConfirmUseCase,
       _changePasswordUseCase = changePasswordUseCase,
       // _googleLoginUseCase = googleLoginUseCase,
       _googleLoginMobileUseCase = googleLoginMobileUseCase,
       // _kakaoLoginUseCase = kakaoLoginUseCase,
       _kakaoLoginMobileUseCase = kakaoLoginMobileUseCase,
       // _naverLoginMobileUseCase = naverLoginMobileUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       _localDataSource = localDataSource,
       _googleSignInService = googleSignInService,
       _kakaoSignInService = kakaoSignInService,
       // _naverSignInService = naverSignInService,
       _loginAttemptService = loginAttemptService,
       // _ref = ref,
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
      // 자동 로그인 설정 확인
      final isAutoLoginEnabled = await _localDataSource.isAutoLoginEnabled();
      debugPrint('🔧 자동 로그인 설정: $isAutoLoginEnabled');

      if (!isAutoLoginEnabled) {
        debugPrint('⏸️ 자동 로그인 비활성화 - 로그인 화면으로 이동');
        state = state.copyWith(isInitialized: true);
        return;
      }

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
                // 토큰 갱신도 실패한 경우에만 인증 데이터 클리어
                _clearAuthData();
              },
              (newToken) async {
                debugPrint('✅ 토큰 갱신 성공');

                // 새 토큰 저장
                await _localDataSource.saveTokens(
                  accessToken: newToken.accessToken,
                  refreshToken: newToken.refreshToken,
                );

                // TokenStorage도 함께 업데이트 (API 클라이언트의 AuthInterceptor와 동기화)
                try {
                  const storage = FlutterSecureStorage(
                    aOptions: AndroidOptions(encryptedSharedPreferences: true),
                    iOptions: IOSOptions(
                      accessibility:
                          KeychainAccessibility.first_unlock_this_device,
                    ),
                  );

                  await Future.wait([
                    storage.write(
                      key: 'access_token',
                      value: newToken.accessToken,
                    ),
                    storage.write(
                      key: 'refresh_token',
                      value: newToken.refreshToken,
                    ),
                  ]);

                  debugPrint('✅ TokenStorage도 새 토큰으로 업데이트 완료');
                } catch (e) {
                  debugPrint('⚠️ TokenStorage 업데이트 실패: $e');
                }

                // 새 토큰으로 사용자 정보 재조회
                final userResult = await _getCurrentUserUseCase.call();
                userResult.fold(
                  (userFailure) {
                    debugPrint(
                      '❌ 토큰 갱신 후에도 사용자 정보 조회 실패: ${userFailure.toString()}',
                    );
                    // 토큰은 유효하므로 인증 상태로 설정하되 사용자 정보는 나중에 로드
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
  // 이 상태에서는 프로필 화면에서 refreshUserInfo()를 호출하여 사용자 정보를 재로드할 수 있음
  void _setAuthenticatedWithoutUser(String accessToken, String refreshToken) {
    debugPrint('⚠️ 사용자 정보 없이 인증 상태 설정 (토큰 유지)');
    debugPrint('   - 프로필 화면에서 사용자 정보 재로드 시도 예정');
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

    // 로그인 시도 전 계정 잠금 상태 확인
    if (_loginAttemptService.isLockedOut()) {
      final status = _loginAttemptService.getStatus();
      state = state.copyWith(
        isLoading: false,
        errorMessage:
            '계정이 일시적으로 잠겨있습니다. ${status.remainingMinutes}분 후에 다시 시도해주세요.',
        isAuthenticated: false,
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );

    final result = await _loginUseCase(
      LoginParams(username: username, password: password),
    );

    result.fold(
      (failure) {
        debugPrint('❌ 로그인 실패: ${failure.toString()}');

        // 로그인 실패 시 시도 횟수 기록
        _loginAttemptService.recordFailedAttempt();
        final attemptStatus = _loginAttemptService.getStatus();

        String errorMessage = _getErrorMessage(failure);

        // 로그인 시도 상태에 따른 경고 메시지 추가
        if (attemptStatus.isWarning) {
          errorMessage += '\n\n⚠️ ${attemptStatus.getWarningMessage()}';
        } else if (attemptStatus.isLockedOut) {
          errorMessage =
              '계정이 일시적으로 잠겨있습니다. ${attemptStatus.remainingMinutes}분 후에 다시 시도해주세요.';
        }

        state = state.copyWith(
          isLoading: false,
          errorMessage: errorMessage,
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

        // 로그인 성공 시 시도 횟수 초기화
        _loginAttemptService.resetAttempts();

        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          user: authResponse.user,
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
          errorMessage: null,
          successMessage: null, // 로그인 성공 시 이전 성공 메시지 클리어
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
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );

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

  // 비밀번호 변경
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    debugPrint('🔄 AuthController.changePassword 호출');
    debugPrint('📍 현재 인증 상태:');
    debugPrint('  - isAuthenticated: ${state.isAuthenticated}');
    debugPrint('  - accessToken 존재: ${state.accessToken != null}');
    debugPrint('  - accessToken 길이: ${state.accessToken?.length ?? 0}');

    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _changePasswordUseCase(
      ChangePasswordParams(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      ),
    );

    result.fold(
      (failure) {
        debugPrint('❌ AuthController.changePassword 실패: ${failure.message}');
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getErrorMessage(failure),
        );
      },
      (successMessage) {
        debugPrint('✅ AuthController.changePassword 성공: $successMessage');
        state = state.copyWith(
          isLoading: false,
          errorMessage: null,
          successMessage: successMessage,
        );
      },
    );
  }

  Future<void> signInWithGoogle({String? code, String? redirectUri}) async {
    // 일반 로딩 상태 대신 Google 로딩 상태만 true로 설정
    state = state.copyWith(isGoogleLoading: true, errorMessage: null);

    try {
      debugPrint('🔄 Google Sign-In 시작');

      // Google Sign-In SDK를 사용하여 실제 로그인 수행
      final String? idToken = await _googleSignInService.signIn();

      if (idToken == null) {
        debugPrint('❌ Google Sign-In 취소됨 또는 실패');
        state = state.copyWith(
          isGoogleLoading: false,
          errorMessage: 'Google 로그인이 취소되었습니다.',
        );
        return;
      }

      debugPrint('✅ Google ID Token 획득 성공');

      // 백엔드 API에 ID Token 전송
      final result = await _googleLoginMobileUseCase(
        GoogleLoginMobileParams(idToken: idToken),
      );

      result.fold(
        (failure) {
          debugPrint('❌ 백엔드 Google 로그인 실패: ${failure.toString()}');
          state = state.copyWith(
            isGoogleLoading: false,
            errorMessage: _getErrorMessage(failure),
          );
        },
        (authResponse) {
          debugPrint('✅ Google 로그인 성공!');
          debugPrint(
            '🔑 토큰 정보: ${authResponse.accessToken.substring(0, 20)}...',
          );
          debugPrint(
            '👤 유저 정보: ${authResponse.user.username}, ${authResponse.user.email}',
          );

          // Google 로그인임을 명시적으로 설정
          final userWithCorrectProvider = authResponse.user.copyWith(
            loginProvider: LoginProvider.google,
          );

          // 소셜 로그인 성공 시에도 로그인 시도 횟수 초기화
          _loginAttemptService.resetAttempts();

          state = state.copyWith(
            isGoogleLoading: false,
            isAuthenticated: true,
            user: userWithCorrectProvider,
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
            errorMessage: null,
            successMessage: AuthMessageHandler.getSuccessMessage(
              action: 'login',
              userName: userWithCorrectProvider.profile.name,
              provider: 'Google',
            ),
          );
        },
      );
    } catch (e) {
      debugPrint('❌ Google Sign-In 예외 발생: $e');
      state = state.copyWith(
        isGoogleLoading: false,
        errorMessage: 'Google 로그인 중 오류가 발생했습니다. 다시 시도해주세요.',
      );
    }
  }

  Future<void> signInWithApple() async {
    state = state.copyWith(isAppleLoading: true, errorMessage: null);

    // Apple Sign-In 미구현
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(
      isAppleLoading: false,
      errorMessage: 'Apple 로그인은 아직 지원하지 않습니다',
    );

    // TODO: Apple 로그인 구현 시 성공 케이스에서 로그인 시도 리셋 추가
    // await _loginAttemptService.resetLoginAttempts();
  }

  Future<void> signInWithKakao({String? code, String? redirectUri}) async {
    state = state.copyWith(isKakaoLoading: true, errorMessage: null);

    try {
      debugPrint('🔄 카카오 로그인 시작');

      // 카카오 SDK를 사용하여 실제 로그인 수행
      final String? accessToken = await _kakaoSignInService.signIn();

      if (accessToken == null) {
        debugPrint('❌ 카카오 로그인 취소됨 또는 실패');
        state = state.copyWith(
          isKakaoLoading: false,
          errorMessage: '카카오 로그인이 취소되었습니다.',
        );
        return;
      }

      debugPrint('✅ 카카오 Access Token 획득 성공');

      // 백엔드 API에 Access Token 전송
      final result = await _kakaoLoginMobileUseCase(
        KakaoLoginMobileParams(accessToken: accessToken),
      );

      result.fold(
        (failure) {
          debugPrint('❌ 백엔드 카카오 로그인 실패: ${failure.toString()}');
          state = state.copyWith(
            isKakaoLoading: false,
            errorMessage: _getErrorMessage(failure),
          );
        },
        (authResponse) {
          debugPrint('✅ 카카오 로그인 성공!');
          debugPrint(
            '🔑 토큰 정보: ${authResponse.accessToken.substring(0, 20)}...',
          );
          debugPrint(
            '👤 유저 정보: ${authResponse.user.username}, ${authResponse.user.email}',
          );

          // 카카오 로그인임을 명시적으로 설정
          final userWithCorrectProvider = authResponse.user.copyWith(
            loginProvider: LoginProvider.kakao,
          );

          // 소셜 로그인 성공 시에도 로그인 시도 횟수 초기화
          _loginAttemptService.resetAttempts();

          state = state.copyWith(
            isKakaoLoading: false,
            isAuthenticated: true,
            user: userWithCorrectProvider,
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
            errorMessage: null,
            successMessage: AuthMessageHandler.getSuccessMessage(
              action: 'login',
              userName: userWithCorrectProvider.profile.name,
              provider: '카카오',
            ),
          );
        },
      );
    } catch (e) {
      debugPrint('❌ 카카오 로그인 예외 발생: $e');
      state = state.copyWith(
        isKakaoLoading: false,
        errorMessage: '카카오 로그인 중 오류가 발생했습니다. 다시 시도해주세요.',
      );
    }
  }

  Future<void> signInWithNaver() async {
    state = state.copyWith(isNaverLoading: true, errorMessage: null);

    // TODO: 네이버 로그인 플러그인 API 호환성 문제로 임시 비활성화
    debugPrint('⚠️ 네이버 로그인 임시 비활성화됨 - 플러그인 API 호환성 문제');

    state = state.copyWith(
      isNaverLoading: false,
      errorMessage: '네이버 로그인은 현재 준비 중입니다. 다른 로그인 방법을 이용해주세요.',
    );
    return;

    // TODO: 네이버 로그인 구현 시 성공 케이스에서 로그인 시도 리셋 추가
    // await _loginAttemptService.resetLoginAttempts();

    /*
    try {
      debugPrint('🔄 네이버 로그인 시작');

      // 네이버 SDK를 사용하여 실제 로그인 수행
      final String? accessToken = await _naverSignInService.signIn();

      if (accessToken == null) {
        debugPrint('❌ 네이버 로그인 취소됨 또는 실패');
        state = state.copyWith(
          isLoading: false,
          errorMessage: '네이버 로그인이 취소되었습니다.',
        );
        return;
      }

      debugPrint('✅ 네이버 Access Token 획득 성공');

      // 백엔드 API에 Access Token 전송
      final result = await _naverLoginMobileUseCase(
        NaverLoginMobileParams(accessToken: accessToken),
      );

      result.fold(
        (failure) {
          debugPrint('❌ 백엔드 네이버 로그인 실패: ${failure.toString()}');
          state = state.copyWith(
            isLoading: false,
            errorMessage: _getErrorMessage(failure),
          );
        },
        (authResponse) {
          debugPrint('✅ 네이버 로그인 성공!');
          debugPrint(
            '🔑 토큰 정보: ${authResponse.accessToken.substring(0, 20)}...',
          );
          debugPrint(
            '👤 유저 정보: ${authResponse.user.username}, ${authResponse.user.email}',
          );

          // 네이버 로그인임을 명시적으로 설정
          final userWithCorrectProvider = authResponse.user.copyWith(
            loginProvider: LoginProvider.naver,
          );

          state = state.copyWith(
            isLoading: false,
            isAuthenticated: true,
            user: userWithCorrectProvider,
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
            errorMessage: null,
          );
        },
      );
    } catch (e) {
      debugPrint('❌ 네이버 로그인 예외 발생: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: '네이버 로그인 중 오류가 발생했습니다. 다시 시도해주세요.',
      );
    }
    */
  }

  /*
  // 임시 비활성화 - 네이버 로그인
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
        (authResponse) async {
          // 로그인 성공 시 시도 횟수 리셋
          await _loginAttemptService.resetLoginAttempts();
          
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
  */

  Future<void> signOut() async {
    if (state.refreshToken == null) {
      await _clearAuthData();
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    // 서버 로그아웃 시도 (결과는 무시하고 로컬 정리를 진행)
    await _logoutUseCase(LogoutParams(refreshToken: state.refreshToken!));

    // Google Sign-In에서도 로그아웃
    try {
      await _googleSignInService.signOut();
      debugPrint('✅ Google Sign-In 로그아웃 완료');
    } catch (e) {
      debugPrint('⚠️ Google Sign-In 로그아웃 중 오류 (무시): $e');
    }

    // 자동 로그인이 비활성화된 경우 토큰 완전 삭제
    final isAutoLoginEnabled = await _localDataSource.isAutoLoginEnabled();
    if (!isAutoLoginEnabled) {
      debugPrint('🔧 자동 로그인 비활성화 - 토큰 완전 삭제');
      await _localDataSource.clearTokens();
    }

    // 서버 로그아웃 성공 여부와 관계없이 로컬 상태 초기화
    await _clearAuthData();
  }

  // 로컬 인증 데이터 초기화
  Future<void> _clearAuthData() async {
    await _localDataSource.clearAuthData();
    state = const AuthState(isInitialized: true);
    debugPrint('🧹 인증 데이터 초기화 완료');
  }

  // 자동 로그인 설정 관련 메서드
  Future<void> setAutoLoginEnabled(bool enabled) async {
    await _localDataSource.setAutoLoginEnabled(enabled);
    debugPrint('🔧 자동 로그인 설정 변경: $enabled');
  }

  Future<bool> isAutoLoginEnabled() async {
    return await _localDataSource.isAutoLoginEnabled();
  }

  // 사용자 정보 재로드 (프로필 화면에서 사용)
  Future<void> refreshUserInfo() async {
    if (!state.isAuthenticated || state.accessToken == null) {
      debugPrint('❌ 인증되지 않은 상태에서 사용자 정보 재로드 시도');
      return;
    }

    debugPrint('🔄 사용자 정보 재로드 시작');

    final result = await _getCurrentUserUseCase.call();

    result.fold(
      (failure) {
        debugPrint('❌ 사용자 정보 재로드 실패: ${failure.toString()}');
        // 실패해도 에러를 표시하지 않고 기존 상태 유지
      },
      (user) {
        debugPrint('✅ 사용자 정보 재로드 성공: ${user.username}');
        state = state.copyWith(user: user);
      },
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null, successMessage: null);
  }

  void setSuccessMessage(String message) {
    state = state.copyWith(successMessage: message);
  }

  String _getErrorMessage(dynamic failure) {
    return AuthMessageHandler.getErrorMessage(failure);
  }

  // 토큰 갱신 후 상태 업데이트 (RefreshTokenInterceptor에서 사용)
  Future<void> updateTokensAfterRefresh(
    String newAccessToken,
    String newRefreshToken,
  ) async {
    debugPrint('🔄 토큰 갱신 후 상태 업데이트');

    // SharedPreferences에도 저장
    await _localDataSource.saveTokens(
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,
    );

    // 상태 업데이트
    state = state.copyWith(
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,
    );

    debugPrint('✅ AuthController 토큰 상태 업데이트 완료');
  }
}
