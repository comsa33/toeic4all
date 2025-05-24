import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/usecases/auth_usecases.dart';

// 인증 상태를 관리하는 클래스
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final User? user;
  final String? errorMessage;
  final String? accessToken;
  final String? refreshToken;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.errorMessage,
    this.accessToken,
    this.refreshToken,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    User? user,
    String? errorMessage,
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}

// 인증 컨트롤러 로직을 관리
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
  })  : _loginUseCase = loginUseCase,
        _signUpUseCase = signUpUseCase,
        _logoutUseCase = logoutUseCase,
        _refreshTokenUseCase = refreshTokenUseCase,
        _passwordResetRequestUseCase = passwordResetRequestUseCase,
        _passwordResetConfirmUseCase = passwordResetConfirmUseCase,
        _changePasswordUseCase = changePasswordUseCase,
        _googleLoginUseCase = googleLoginUseCase,
        _kakaoLoginUseCase = kakaoLoginUseCase,
        _naverLoginUseCase = naverLoginUseCase,
        super(const AuthState());

  // 사용자 이름과 비밀번호로 로그인
  Future<void> signInWithUsername({
    required String username,
    required String password,
  }) async {
    // 로딩 상태로 변경
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    debugPrint('🔄 로그인 요청 중: $username');

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
        debugPrint('🔑 토큰 정보: ${authResponse.accessToken.substring(0, 10)}... (${authResponse.accessToken.length}자)');
        
        // 사용자 정보가 있다면 로깅
        if (authResponse.user != null) {
          debugPrint('👤 사용자: ${authResponse.user.username} (${authResponse.user.email})');
        } else {
          debugPrint('⚠️ 사용자 정보 없음 - API 응답에 사용자 정보가 포함되어 있지 않음');
        }

        // 인증 상태 업데이트
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,  // 이 부분이 중요: 인증 상태를 true로 설정
          user: authResponse.user,
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
          errorMessage: null,
        );
        
        // 상태가 제대로 설정되었는지 확인
        debugPrint('🔄 인증 상태 업데이트 완료: isAuthenticated=${state.isAuthenticated}');
      },
    );
  }

  // 구글 로그인
  Future<void> signInWithGoogle({String? code, String? redirectUri}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    // 사용자가 외부 Google 인증 페이지를 통해 코드를 받아온 경우
    if (code != null && redirectUri != null) {
      final result = await _googleLoginUseCase(
        GoogleLoginParams(code: code, redirectUri: redirectUri),
      );
      
      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: _getErrorMessage(failure),
            isAuthenticated: false,
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
      // 외부 브라우저로 Google 인증 페이지 열기
      state = state.copyWith(
        isLoading: false,
        errorMessage: '구글 로그인을 시작합니다...',
      );
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    if (state.refreshToken == null) {
      state = const AuthState();
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _logoutUseCase(
      LogoutParams(refreshToken: state.refreshToken!),
    );

    // 로컬 상태 초기화 (서버 로그아웃 실패해도)
    state = const AuthState();
  }

  // 에러 메시지 초기화 
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  // 에러 메시지 포맷팅
  String _getErrorMessage(dynamic failure) {
    return '로그인에 실패했습니다. 다시 시도해 주세요.';
  }
}
