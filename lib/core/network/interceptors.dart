import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_endpoints.dart';
import '../errors/exceptions.dart';

// 토큰 스토리지 Provider
final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

class TokenStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
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
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final tokenStorage = _ref.read(tokenStorageProvider);
      final token = await tokenStorage.getAccessToken();
      
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      
      handler.next(options);
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Failed to add authorization header',
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
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    print('Data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
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
            exception = ServerException(message: message, statusCode: statusCode);
            break;
        }
        break;
      case DioExceptionType.cancel:
        // 요청이 취소된 경우는 에러로 처리하지 않음
        handler.next(err);
        return;
      case DioExceptionType.unknown:
      default:
        exception = ServerException(message: err.message ?? '알 수 없는 오류가 발생했습니다');
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
      
      try {
        final tokenStorage = _ref.read(tokenStorageProvider);
        final refreshToken = await tokenStorage.getRefreshToken();
        
        if (refreshToken != null) {
          final dio = Dio();
          final response = await dio.post(
            '${ApiEndpoints.baseUrl}${ApiEndpoints.refreshToken}',
            data: {'refresh_token': refreshToken},
          );
          
          final newAccessToken = response.data['access_token'];
          final newRefreshToken = response.data['refresh_token'];
          
          await tokenStorage.saveTokens(newAccessToken, newRefreshToken);
          
          // 원래 요청 재시도
          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          
          final retryResponse = await Dio().fetch(requestOptions);
          handler.resolve(retryResponse);
        } else {
          // 리프레시 토큰이 없으면 로그아웃
          await tokenStorage.deleteTokens();
          handler.next(err);
        }
      } catch (e) {
        // 토큰 갱신 실패 시 로그아웃
        await _ref.read(tokenStorageProvider).deleteTokens();
        handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      handler.next(err);
    }
  }
}
