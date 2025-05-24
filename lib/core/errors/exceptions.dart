// 사용자 정의 예외 클래스들

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  
  const ServerException({
    required this.message,
    this.statusCode,
  });
  
  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

class CacheException implements Exception {
  final String message;
  
  const CacheException({required this.message});
  
  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;
  
  const NetworkException({required this.message});
  
  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {
  final String message;
  final String? code;
  
  const AuthException({
    required this.message,
    this.code,
  });
  
  @override
  String toString() => 'AuthException: $message (Code: $code)';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? errors;
  
  const ValidationException({
    required this.message,
    this.errors,
  });
  
  @override
  String toString() => 'ValidationException: $message';
}

class NotFoundException implements Exception {
  final String message;
  
  const NotFoundException({required this.message});
  
  @override
  String toString() => 'NotFoundException: $message';
}

class UnauthorizedException implements Exception {
  final String message;
  
  const UnauthorizedException({required this.message});
  
  @override
  String toString() => 'UnauthorizedException: $message';
}

class ForbiddenException implements Exception {
  final String message;
  
  const ForbiddenException({required this.message});
  
  @override
  String toString() => 'ForbiddenException: $message';
}

class TimeoutException implements Exception {
  final String message;
  
  const TimeoutException({required this.message});
  
  @override
  String toString() => 'TimeoutException: $message';
}
