import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../entities/auth_response.dart';

abstract class AuthRepository {
  // 로그인
  Future<Either<Failure, AuthResponse>> login({
    required String username,
    required String password,
  });

  // 회원가입
  Future<Either<Failure, User>> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  });

  // 토큰 새로고침
  Future<Either<Failure, Token>> refreshToken(String refreshToken);

  // 로그아웃
  Future<Either<Failure, void>> logout(String refreshToken);

  // 비밀번호 재설정 요청
  Future<Either<Failure, void>> requestPasswordReset(String email);

  // 비밀번호 재설정 확인
  Future<Either<Failure, void>> confirmPasswordReset({
    required String token,
    required String newPassword,
    required String confirmPassword,
  });

  // 비밀번호 변경
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  // 이메일 인증
  Future<Either<Failure, void>> verifyEmail({
    required String token,
  });

  // 이메일 인증 재전송
  Future<Either<Failure, void>> resendVerification(String email);

  // 계정 삭제
  Future<Either<Failure, void>> deleteAccount(String password);

  // 세션 관리
  Future<Either<Failure, List<Session>>> getSessions();
  Future<Either<Failure, void>> deleteSession(String sessionId);

  // 비밀번호 상태 확인
  Future<Either<Failure, PasswordStatus>> getPasswordStatus();

  // 계정 잠금 해제
  Future<Either<Failure, void>> unlockAccount({
    required String email,
    required String unlockCode,
  });

  // 소셜 로그인
  Future<Either<Failure, AuthResponse>> googleLogin({
    required String code,
    required String redirectUri,
  });

  Future<Either<Failure, AuthResponse>> googleLoginMobile({
    required String idToken,
    String? accessToken,
  });

  Future<Either<Failure, AuthResponse>> kakaoLogin({
    required String code,
    required String redirectUri,
  });

  Future<Either<Failure, AuthResponse>> kakaoLoginMobile({
    required String accessToken,
  });

  Future<Either<Failure, AuthResponse>> naverLoginMobile({
    required String accessToken,
  });

  /*
  // 임시 비활성화 - 네이버 로그인
  Future<Either<Failure, AuthResponse>> naverLogin({
    required String code,
    required String redirectUri,
    required String state,
  });
  */

  // 로그인 상태 확인
  Future<bool> isLoggedIn();

  // 현재 사용자 정보 조회
  Future<Either<Failure, User>> getCurrentUser();
}

// 추가 엔티티들
class Token {
  final String accessToken;
  final String refreshToken;
  final DateTime? expiresAt;

  const Token({
    required this.accessToken,
    required this.refreshToken,
    this.expiresAt,
  });
}

class Session {
  final String id;
  final String deviceName;
  final String ipAddress;
  final DateTime lastActive;
  final bool isCurrent;

  const Session({
    required this.id,
    required this.deviceName,
    required this.ipAddress,
    required this.lastActive,
    required this.isCurrent,
  });
}

class PasswordStatus {
  final bool hasPassword;
  final DateTime? lastChanged;
  final bool isExpired;

  const PasswordStatus({
    required this.hasPassword,
    this.lastChanged,
    required this.isExpired,
  });
}
