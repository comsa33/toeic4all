import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_endpoints.dart';
import '../errors/exceptions.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';

// 토큰 스토리지 Provider
final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

class TokenStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
    ]);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> deleteTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
    ]);
  }

  Future<bool> hasTokens() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }
}

// 인증 인터셉터
class AuthInterceptor extends Interceptor {
  final Ref _ref;

  AuthInterceptor(this._ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      print('🔍 API 요청: ${options.method} ${options.path}');
      
      // AuthController에서 현재 액세스 토큰을 가져옴
      final authState = _ref.read(authControllerProvider);
      
      print('🔍 Auth State 확인:');
      print('  - isAuthenticated: ${authState.isAuthenticated}');
      print('  - accessToken 존재: ${authState.accessToken != null}');
      print('  - accessToken 길이: ${authState.accessToken?.length ?? 0}');
      
      if (authState.accessToken != null && authState.accessToken!.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer ${authState.accessToken}';
        print('✅ Authorization 헤더 추가됨: Bearer ${authState.accessToken!.substring(0, math.min(20, authState.accessToken!.length))}...');
      } else {
        print('⚠️ 액세스 토큰이 없거나 비어있습니다');
        print('⚠️ 현재 요청 경로: ${options.path}');
      }

      print('🔍 최종 요청 헤더: ${options.headers}');
      handler.next(options);
    } catch (e) {
      print('❌ Authorization 헤더 추가 실패: $e');
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Failed to add authorization header: $e',
        ),
      );
    }
  }
}

// 로깅 인터셉터
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    print('Headers: ${options.headers}');
    if (options.data != null) {
      print('Data: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    print('Data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    print('Message: ${err.message}');
    handler.next(err);
  }
}

// 에러 인터셉터
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Exception exception;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = const TimeoutException(message: '요청 시간이 초과되었습니다');
        break;
      case DioExceptionType.connectionError:
        exception = const NetworkException(message: '네트워크 연결을 확인해주세요');
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = err.response?.data?['message'] ?? '서버 오류가 발생했습니다';

        switch (statusCode) {
          case 400:
            exception = ValidationException(message: message);
            break;
          case 401:
            exception = UnauthorizedException(message: message);
            break;
          case 403:
            exception = ForbiddenException(message: message);
            break;
          case 404:
            exception = NotFoundException(message: message);
            break;
          case 500:
          default:
            exception = ServerException(
              message: message,
              statusCode: statusCode,
            );
            break;
        }
        break;
      case DioExceptionType.cancel:
        // 요청이 취소된 경우는 에러로 처리하지 않음
        handler.next(err);
        return;
      case DioExceptionType.unknown:
      default:
        exception = ServerException(
          message: err.message ?? '알 수 없는 오류가 발생했습니다',
        );
        break;
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        error: exception,
      ),
    );
  }
}

// 토큰 갱신 인터셉터
class RefreshTokenInterceptor extends Interceptor {
  final Ref _ref;
  bool _isRefreshing = false;

  RefreshTokenInterceptor(this._ref);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      print('🔄 401 오류 감지 - 토큰 갱신 시도');

      try {
        // AuthController에서 현재 리프레시 토큰을 가져옴
        final authState = _ref.read(authControllerProvider);
        final refreshToken = authState.refreshToken;

        if (refreshToken != null && refreshToken.isNotEmpty) {
          print('🔑 리프레시 토큰 발견: ${refreshToken.substring(0, 20)}...');
          
          final dio = Dio();
          final response = await dio.post(
            '${ApiEndpoints.baseUrl}${ApiEndpoints.refreshToken}',
            data: {'refresh_token': refreshToken},
          );

          final newAccessToken = response.data['access_token'];
          final newRefreshToken = response.data['refresh_token'];

          print('✅ 토큰 갱신 성공: ${newAccessToken.substring(0, 20)}...');

          // AuthController의 토큰 갱신 메서드 호출 (내부에서 상태 업데이트)
          // 이 부분은 AuthController에 적절한 메서드가 있다고 가정
          // 실제로는 TokenStorage도 함께 업데이트해야 함
          await _updateTokensInStorage(newAccessToken, newRefreshToken);

          // 원래 요청 재시도
          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

          final retryResponse = await Dio().fetch(requestOptions);
          print('✅ 원본 요청 재시도 성공');
          handler.resolve(retryResponse);
        } else {
          print('❌ 리프레시 토큰이 없음 - 로그아웃 처리');
          // 리프레시 토큰이 없으면 로그아웃
          final authController = _ref.read(authControllerProvider.notifier);
          await authController.signOut();
          handler.next(err);
        }
      } catch (e) {
        print('❌ 토큰 갱신 실패: $e');
        // 토큰 갱신 실패 시 로그아웃
        final authController = _ref.read(authControllerProvider.notifier);
        await authController.signOut();
        handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      handler.next(err);
    }
  }

  // 토큰 갱신 후 로컬 스토리지 업데이트
  Future<void> _updateTokensInStorage(String accessToken, String refreshToken) async {
    try {
      // SharedPreferences에 저장 (AuthLocalDataSource와 동일한 방식)
      final prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.setString('access_token', accessToken),
        prefs.setString('refresh_token', refreshToken),
      ]);
      print('✅ SharedPreferences 토큰 업데이트 완료');
    } catch (e) {
      print('⚠️ SharedPreferences 토큰 업데이트 실패: $e');
    }
  }
}
