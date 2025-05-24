import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/repositories/auth_repository.dart' show AuthRepository, Token, Session, PasswordStatus;
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, AuthResponse>> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signInWithUsername(
        username: username,
        password: password,
      );
      
      // Cache the auth response locally
      await _localDataSource.cacheAuthResponse(result);
      
      return Right(result.toEntity());
    } on ValidationException catch (e) {
      return Left(Failure.validation(message: e.message));
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final result = await _remoteDataSource.signUpWithEmail(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      
      return Right(result.toEntity().user);
    } on ValidationException catch (e) {
      return Left(Failure.validation(message: e.message));
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Token>> refreshToken(String refreshToken) async {
    try {
      final result = await _remoteDataSource.refreshToken(refreshToken);
      
      // Cache the new tokens
      await _localDataSource.cacheAuthResponse(result);
      
      return Right(Token(
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      ));
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout(String refreshToken) async {
    try {
      await _remoteDataSource.signOut();
      await _localDataSource.clearAuthData();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> requestPasswordReset(String email) async {
    try {
      await _remoteDataSource.resetPassword(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> confirmPasswordReset({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      // Implementation needed in remote data source
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      // Implementation needed in remote data source
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail({
    required String token,
  }) async {
    try {
      // Implementation needed in remote data source
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resendVerification(String email) async {
    try {
      // Implementation needed in remote data source
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String password) async {
    try {
      // Implementation needed in remote data source
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Session>>> getSessions() async {
    try {
      // Implementation needed in remote data source
      return const Right([]);
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSession(String sessionId) async {
    try {
      // Implementation needed in remote data source
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PasswordStatus>> getPasswordStatus() async {
    try {
      // Implementation needed in remote data source
      return const Right(PasswordStatus(
        hasPassword: true,
        isExpired: false,
      ));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unlockAccount({
    required String email,
    required String unlockCode,
  }) async {
    try {
      // Implementation needed in remote data source
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> googleLogin({
    required String code,
    required String redirectUri,
  }) async {
    try {
      final result = await _remoteDataSource.signInWithGoogle(
        code: code,
        redirectUri: redirectUri,
      );
      await _localDataSource.cacheAuthResponse(result);
      return Right(result.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> kakaoLogin({
    required String code,
    required String redirectUri,
  }) async {
    try {
      final result = await _remoteDataSource.signInWithKakao(
        code: code,
        redirectUri: redirectUri,
      );
      await _localDataSource.cacheAuthResponse(result);
      return Right(result.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> naverLogin({
    required String code,
    required String redirectUri,
    required String state,
  }) async {
    try {
      final result = await _remoteDataSource.signInWithNaver(
        code: code,
        redirectUri: redirectUri,
        state: state,
      );
      await _localDataSource.cacheAuthResponse(result);
      return Right(result.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final cachedUser = await _localDataSource.getCachedUser();
      return cachedUser != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      // Try to get cached user first
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Right(cachedUser.toEntity());
      }
      
      // If no cached user, fetch from remote
      final result = await _remoteDataSource.getCurrentUser();
      await _localDataSource.cacheUser(result);
      return Right(result.toEntity());
    } on AuthException catch (e) {
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }
}
