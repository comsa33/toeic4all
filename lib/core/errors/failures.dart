import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

// Failure 클래스들 - 비즈니스 로직 레이어에서 사용
@freezed
class Failure with _$Failure {
  const factory Failure.server({
    required String message,
    int? statusCode,
  }) = ServerFailure;
  
  const factory Failure.cache({
    required String message,
  }) = CacheFailure;
  
  const factory Failure.network({
    required String message,
  }) = NetworkFailure;
  
  const factory Failure.auth({
    required String message,
    String? code,
  }) = AuthFailure;
  
  const factory Failure.validation({
    required String message,
    Map<String, String>? errors,
  }) = ValidationFailure;
  
  const factory Failure.notFound({
    required String message,
  }) = NotFoundFailure;
  
  const factory Failure.unauthorized({
    required String message,
  }) = UnauthorizedFailure;
  
  const factory Failure.forbidden({
    required String message,
  }) = ForbiddenFailure;
  
  const factory Failure.timeout({
    required String message,
  }) = TimeoutFailure;
  
  const factory Failure.unknown({
    required String message,
  }) = UnknownFailure;
}

// Failure 확장 메서드
extension FailureX on Failure {
  String get displayMessage {
    return when(
      server: (message, statusCode) => message,
      cache: (message) => message,
      network: (message) => '네트워크 연결을 확인해주세요',
      auth: (message, code) => message,
      validation: (message, errors) => message,
      notFound: (message) => message,
      unauthorized: (message) => '인증이 필요합니다',
      forbidden: (message) => '접근 권한이 없습니다',
      timeout: (message) => '요청 시간이 초과되었습니다',
      unknown: (message) => '알 수 없는 오류가 발생했습니다',
    );
  }
  
  bool get isAuthRelated {
    return when(
      server: (_, __) => false,
      cache: (_) => false,
      network: (_) => false,
      auth: (_, __) => true,
      validation: (_, __) => false,
      notFound: (_) => false,
      unauthorized: (_) => true,
      forbidden: (_) => true,
      timeout: (_) => false,
      unknown: (_) => false,
    );
  }
}
