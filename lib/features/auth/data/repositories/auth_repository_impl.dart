import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/repositories/auth_repository.dart'
    show AuthRepository, Token, Session, PasswordStatus;
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
  }) : _remoteDataSource = remoteDataSource,
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

      // 새로운 토큰을 로컬에 저장
      await _localDataSource.saveTokens(
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      );

      return Right(
        Token(
          accessToken: result.accessToken,
          refreshToken: result.refreshToken,
          expiresAt: DateTime.now().add(Duration(seconds: result.expiresIn)),
        ),
      );
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
  Future<Either<Failure, String>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      debugPrint('🔄 AuthRepository.changePassword 호출 시작');
      debugPrint('📍 매개변수 확인:');
      debugPrint('  - currentPassword 길이: ${currentPassword.length}');
      debugPrint('  - newPassword 길이: ${newPassword.length}');
      debugPrint('  - confirmPassword 길이: ${confirmPassword.length}');
      
      final successMessage = await _remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      
      debugPrint('✅ AuthRepository.changePassword 성공: $successMessage');
      return Right(successMessage);
    } on ValidationException catch (e) {
      debugPrint('❌ AuthRepository.changePassword 검증 오류: ${e.message}');
      return Left(Failure.validation(message: e.message));
    } on AuthException catch (e) {
      debugPrint('❌ AuthRepository.changePassword 인증 오류: ${e.message}');
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      debugPrint('❌ AuthRepository.changePassword 서버 오류: ${e.message}');
      return Left(Failure.server(message: e.message));
    } catch (e) {
      debugPrint('❌ AuthRepository.changePassword 알 수 없는 오류: $e');
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail({required String token}) async {
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
      return const Right(PasswordStatus(hasPassword: true, isExpired: false));
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
  Future<Either<Failure, AuthResponse>> googleLoginMobile({
    required String idToken,
    String? accessToken,
  }) async {
    try {
      debugPrint('🔄 모바일 Google 로그인 Repository 호출');
      final result = await _remoteDataSource.signInWithGoogleMobile(
        idToken: idToken,
        accessToken: accessToken,
      );
      await _localDataSource.cacheAuthResponse(result);
      debugPrint('✅ 모바일 Google 로그인 Repository 성공');
      return Right(result.toEntity());
    } on AuthException catch (e) {
      debugPrint('❌ 모바일 Google 로그인 인증 오류: ${e.message}');
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      debugPrint('❌ 모바일 Google 로그인 서버 오류: ${e.message}');
      return Left(Failure.server(message: e.message));
    } catch (e) {
      debugPrint('❌ 모바일 Google 로그인 알 수 없는 오류: $e');
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
  Future<Either<Failure, AuthResponse>> kakaoLoginMobile({
    required String accessToken,
  }) async {
    try {
      debugPrint('🔄 모바일 카카오 로그인 Repository 호출');
      final result = await _remoteDataSource.signInWithKakaoMobile(
        accessToken: accessToken,
      );
      await _localDataSource.cacheAuthResponse(result);
      debugPrint('✅ 모바일 카카오 로그인 Repository 성공');
      return Right(result.toEntity());
    } on AuthException catch (e) {
      debugPrint('❌ 모바일 카카오 로그인 인증 오류: ${e.message}');
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      debugPrint('❌ 모바일 카카오 로그인 서버 오류: ${e.message}');
      return Left(Failure.server(message: e.message));
    } catch (e) {
      debugPrint('❌ 모바일 카카오 로그인 알 수 없는 오류: $e');
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> naverLoginMobile({
    required String accessToken,
  }) async {
    try {
      debugPrint('🔄 모바일 네이버 로그인 Repository 호출');
      final result = await _remoteDataSource.signInWithNaverMobile(
        accessToken: accessToken,
      );
      await _localDataSource.cacheAuthResponse(result);
      debugPrint('✅ 모바일 네이버 로그인 Repository 성공');
      return Right(result.toEntity());
    } on AuthException catch (e) {
      debugPrint('❌ 모바일 네이버 로그인 인증 오류: ${e.message}');
      return Left(Failure.auth(message: e.message));
    } on ServerException catch (e) {
      debugPrint('❌ 모바일 네이버 로그인 서버 오류: ${e.message}');
      return Left(Failure.server(message: e.message));
    } catch (e) {
      debugPrint('❌ 모바일 네이버 로그인 알 수 없는 오류: $e');
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  /*
  // 임시 비활성화 - 네이버 로그인
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
  */

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
