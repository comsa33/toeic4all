import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/usecases/auth_usecases.dart';

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

  Future<void> signInWithUsername({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _loginUseCase(
      LoginParams(username: username, password: password),
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
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
          errorMessage: null,
        );
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
        state = state.copyWith(
          isLoading: false,
          user: user,
          errorMessage: null,
        );
      },
    );
  }

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
      // 여기서 웹뷰나 외부 브라우저를 열어 인증할 수 있음
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Google 로그인 URL: https://accounts.google.com/o/oauth2/v2/auth?client_id=492018860076-5c1jfbpkk33c914rkh05k0he8c25thj6.apps.googleusercontent.com&redirect_uri=https://toeic4all-apis.po24lio.com/api/v1/docs&scope=email%20profile&response_type=code',
      );
    }
  }

  Future<void> signInWithApple() async {
    // Placeholder implementation
    state = (state ?? const AuthState()).copyWith(isLoading: true, errorMessage: null);
    state = state.copyWith(
      isLoading: false,
      errorMessage: 'Apple 로그인은 아직 지원하지 않습니다',
    );
  }

  Future<void> signInWithKakao({String? code, String? redirectUri}) async {
    state = (state ?? const AuthState()).copyWith(isLoading: true, errorMessage: null);
    
    // 사용자가 외부 Kakao 인증 페이지를 통해 코드를 받아온 경우
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
      // 외부 브라우저로 Kakao 인증 페이지 열기
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Kakao 로그인 URL: https://kauth.kakao.com/oauth/authorize?client_id=b814e58f7a794e1924ab668f19b9a018&redirect_uri=https://toeic4all-apis.po24lio.com/api/v1/docs&response_type=code',
      );
    }
  }
  
  Future<void> signInWithNaver({String? code, String? redirectUri, String? naverState}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    // 사용자가 외부 Naver 인증 페이지를 통해 코드를 받아온 경우
    if (code != null && redirectUri != null && naverState != null) {
      final result = await _naverLoginUseCase(
        NaverLoginParams(code: code, redirectUri: redirectUri, state: naverState),
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
      // 외부 브라우저로 Naver 인증 페이지 열기
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Naver 로그인 URL: https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=dPEWiT72BQLlRtc_u4qN&redirect_uri=https://toeic4all-apis.po24lio.com/api/v1/docs&state=TOEIC4ALL',
      );
    }
  }

  Future<void> signOut() async {
    if (state.refreshToken == null) {
      state = const AuthState();
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _logoutUseCase(
      LogoutParams(refreshToken: state.refreshToken!),
    );

    result.fold(
      (failure) {
        // Even if logout fails on server, clear local state
        state = const AuthState();
      },
      (_) {
        state = const AuthState();
      },
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  String _getErrorMessage(dynamic failure) {
    // TODO: Implement proper error message handling based on failure type
    return 'An error occurred. Please try again.';
  }
}