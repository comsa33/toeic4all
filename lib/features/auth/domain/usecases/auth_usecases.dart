import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';

// Login UseCase
class LoginUseCase implements UseCase<AuthResponse, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(LoginParams params) async {
    return await repository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({
    required this.username,
    required this.password,
  });
}

// Register UseCase
class SignUpUseCase implements UseCase<User, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.register(
      username: params.username,
      email: params.email,
      password: params.password,
      confirmPassword: params.confirmPassword,
    );
  }
}

class SignUpParams {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpParams({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

// Refresh Token UseCase
class RefreshTokenUseCase implements UseCase<Token, RefreshTokenParams> {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  @override
  Future<Either<Failure, Token>> call(RefreshTokenParams params) async {
    return await repository.refreshToken(params.refreshToken);
  }
}

class RefreshTokenParams {
  final String refreshToken;

  RefreshTokenParams({
    required this.refreshToken,
  });
}

// Logout UseCase
class LogoutUseCase implements UseCase<void, LogoutParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(LogoutParams params) async {
    return await repository.logout(params.refreshToken);
  }
}

class LogoutParams {
  final String refreshToken;

  LogoutParams({
    required this.refreshToken,
  });
}

// Password Reset Request UseCase
class PasswordResetRequestUseCase implements UseCase<void, PasswordResetRequestParams> {
  final AuthRepository repository;

  PasswordResetRequestUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(PasswordResetRequestParams params) async {
    return await repository.requestPasswordReset(params.email);
  }
}

class PasswordResetRequestParams {
  final String email;

  PasswordResetRequestParams({
    required this.email,
  });
}

// Password Reset Confirm UseCase
class PasswordResetConfirmUseCase implements UseCase<void, PasswordResetConfirmParams> {
  final AuthRepository repository;

  PasswordResetConfirmUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(PasswordResetConfirmParams params) async {
    return await repository.confirmPasswordReset(
      token: params.token,
      newPassword: params.newPassword,
      confirmPassword: params.confirmPassword,
    );
  }
}

class PasswordResetConfirmParams {
  final String token;
  final String newPassword;
  final String confirmPassword;

  PasswordResetConfirmParams({
    required this.token,
    required this.newPassword,
    required this.confirmPassword,
  });
}

// Change Password UseCase
class ChangePasswordUseCase implements UseCase<void, ChangePasswordParams> {
  final AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    return await repository.changePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
      confirmPassword: params.confirmPassword,
    );
  }
}

class ChangePasswordParams {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}

// Social Login UseCase - Google
class GoogleLoginUseCase implements UseCase<AuthResponse, GoogleLoginParams> {
  final AuthRepository repository;

  GoogleLoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(GoogleLoginParams params) async {
    return await repository.googleLogin(
      code: params.code,
      redirectUri: params.redirectUri,
    );
  }
}

class GoogleLoginParams {
  final String code;
  final String redirectUri;

  GoogleLoginParams({
    required this.code,
    required this.redirectUri,
  });
}

// Social Login UseCase - Kakao
class KakaoLoginUseCase implements UseCase<AuthResponse, KakaoLoginParams> {
  final AuthRepository repository;

  KakaoLoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(KakaoLoginParams params) async {
    return await repository.kakaoLogin(
      code: params.code,
      redirectUri: params.redirectUri,
    );
  }
}

class KakaoLoginParams {
  final String code;
  final String redirectUri;

  KakaoLoginParams({
    required this.code,
    required this.redirectUri,
  });
}

// Social Login UseCase - Naver
class NaverLoginUseCase implements UseCase<AuthResponse, NaverLoginParams> {
  final AuthRepository repository;

  NaverLoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(NaverLoginParams params) async {
    return await repository.naverLogin(
      code: params.code,
      redirectUri: params.redirectUri,
      state: params.state,
    );
  }
}

class NaverLoginParams {
  final String code;
  final String redirectUri;
  final String state;

  NaverLoginParams({
    required this.code,
    required this.redirectUri,
    required this.state,
  });
}

class GetCurrentUserUseCase implements NoParamsUseCase<User> {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call() async {
    return await repository.getCurrentUser();
  }
}

class RequestPasswordResetUseCase implements UseCase<void, RequestPasswordResetParams> {
  final AuthRepository repository;

  RequestPasswordResetUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RequestPasswordResetParams params) async {
    return await repository.requestPasswordReset(params.email);
  }
}

class RequestPasswordResetParams {
  final String email;

  RequestPasswordResetParams({required this.email});
}

class ResetPasswordUseCase implements UseCase<void, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await repository.confirmPasswordReset(
      token: params.token,
      newPassword: params.newPassword,
      confirmPassword: params.newPassword,
    );
  }
}

class ResetPasswordParams {
  final String token;
  final String newPassword;

  ResetPasswordParams({
    required this.token,
    required this.newPassword,
  });
}
