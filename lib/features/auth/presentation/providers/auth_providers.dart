import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/services/google_sign_in_service.dart';
import '../../../../core/services/kakao_sign_in_service.dart';
import '../../../../core/services/naver_sign_in_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth_usecases.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../controllers/auth_controller.dart';

// Shared Preferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized');
});

// API Client Provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref);
});

// Data Sources
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRemoteDataSourceImpl(apiClient);
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthLocalDataSourceImpl(prefs);
});

// Google Sign-In Service
final googleSignInServiceProvider = Provider<GoogleSignInService>((ref) {
  return GoogleSignInService();
});

// Kakao Sign-In Service
final kakaoSignInServiceProvider = Provider<KakaoSignInService>((ref) {
  return KakaoSignInService();
});

// Naver Sign-In Service
final naverSignInServiceProvider = Provider<NaverSignInService>((ref) {
  return NaverSignInService();
});

// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

// Use Cases
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignUpUseCase(repository);
});

final refreshTokenUseCaseProvider = Provider<RefreshTokenUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RefreshTokenUseCase(repository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository);
});

final passwordResetRequestUseCaseProvider =
    Provider<PasswordResetRequestUseCase>((ref) {
      final repository = ref.watch(authRepositoryProvider);
      return PasswordResetRequestUseCase(repository);
    });

final passwordResetConfirmUseCaseProvider =
    Provider<PasswordResetConfirmUseCase>((ref) {
      final repository = ref.watch(authRepositoryProvider);
      return PasswordResetConfirmUseCase(repository);
    });

final changePasswordUseCaseProvider = Provider<ChangePasswordUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return ChangePasswordUseCase(repository);
});

final googleLoginUseCaseProvider = Provider<GoogleLoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GoogleLoginUseCase(repository);
});

final googleLoginMobileUseCaseProvider = Provider<GoogleLoginMobileUseCase>((
  ref,
) {
  final repository = ref.watch(authRepositoryProvider);
  return GoogleLoginMobileUseCase(repository);
});

final kakaoLoginUseCaseProvider = Provider<KakaoLoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return KakaoLoginUseCase(repository);
});

final kakaoLoginMobileUseCaseProvider = Provider<KakaoLoginMobileUseCase>((
  ref,
) {
  final repository = ref.watch(authRepositoryProvider);
  return KakaoLoginMobileUseCase(repository);
});

final naverLoginMobileUseCaseProvider = Provider<NaverLoginMobileUseCase>((
  ref,
) {
  final repository = ref.watch(authRepositoryProvider);
  return NaverLoginMobileUseCase(repository);
});

// 임시 비활성화 - 네이버 로그인
/*
final naverLoginUseCaseProvider = Provider<NaverLoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return NaverLoginUseCase(repository);
});
*/

// 새로 추가된 UseCase
final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(repository);
});

// Auth Controller Provider - 의존성 추가
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(
      loginUseCase: ref.watch(loginUseCaseProvider),
      signUpUseCase: ref.watch(signUpUseCaseProvider),
      logoutUseCase: ref.watch(logoutUseCaseProvider),
      refreshTokenUseCase: ref.watch(refreshTokenUseCaseProvider),
      passwordResetRequestUseCase: ref.watch(
        passwordResetRequestUseCaseProvider,
      ),
      passwordResetConfirmUseCase: ref.watch(
        passwordResetConfirmUseCaseProvider,
      ),
      changePasswordUseCase: ref.watch(changePasswordUseCaseProvider),
      googleLoginUseCase: ref.watch(googleLoginUseCaseProvider),
      googleLoginMobileUseCase: ref.watch(googleLoginMobileUseCaseProvider),
      kakaoLoginUseCase: ref.watch(kakaoLoginUseCaseProvider),
      kakaoLoginMobileUseCase: ref.watch(kakaoLoginMobileUseCaseProvider),
      naverLoginMobileUseCase: ref.watch(naverLoginMobileUseCaseProvider),
      getCurrentUserUseCase: ref.watch(getCurrentUserUseCaseProvider),
      localDataSource: ref.watch(authLocalDataSourceProvider),
      googleSignInService: ref.watch(googleSignInServiceProvider),
      kakaoSignInService: ref.watch(kakaoSignInServiceProvider),
      naverSignInService: ref.watch(naverSignInServiceProvider),
      ref: ref, // Ref 전달
    );
  },
);
