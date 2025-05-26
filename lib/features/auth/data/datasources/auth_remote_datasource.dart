import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signInWithUsername({
    required String username,
    required String password,
  });

  Future<AuthResponseModel> signUpWithEmail({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<AuthResponseModel> signInWithGoogle({
    required String code,
    required String redirectUri,
  });
  Future<AuthResponseModel> signInWithApple();
  Future<AuthResponseModel> signInWithKakao({
    required String code,
    required String redirectUri,
  });
  Future<AuthResponseModel> signInWithNaver({
    required String code,
    required String redirectUri,
    required String state,
  });

  Future<void> signOut();
  Future<AuthResponseModel> refreshToken(String refreshToken);
  Future<UserModel> getCurrentUser();
  Future<void> resetPassword(String email);
  Future<UserModel> updateProfile({String? name, String? profileImageUrl});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<AuthResponseModel> signInWithUsername({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.login,
        data: {'username': username, 'password': password},
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<AuthResponseModel> signUpWithEmail({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.register,
        data: {
          'username': username,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<AuthResponseModel> signInWithGoogle({
    required String code,
    required String redirectUri,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.googleLogin,
        queryParameters: {'code': code, 'redirect_uri': redirectUri},
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<AuthResponseModel> signInWithApple() async {
    try {
      // Apple Sign-In logic will be implemented here
      // This would typically use sign_in_with_apple package
      throw UnimplementedError('Apple Sign-In not implemented yet');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<AuthResponseModel> signInWithKakao({
    required String code,
    required String redirectUri,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.kakaoLogin,
        queryParameters: {'code': code, 'redirect_uri': redirectUri},
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<AuthResponseModel> signInWithNaver({
    required String code,
    required String redirectUri,
    required String state,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.naverLogin,
        queryParameters: {
          'code': code,
          'redirect_uri': redirectUri,
          'state': state,
        },
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _apiClient.post(ApiEndpoints.signOut);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<AuthResponseModel> refreshToken(String refreshToken) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.refreshToken,
        data: {'refresh_token': refreshToken},
      );

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.currentUser);
      final data = response.data as Map<String, dynamic>;

      debugPrint('🔍 서버에서 받은 사용자 데이터: ${data.toString()}');

      // API 스펙에 맞게 데이터 매핑 (UserMeResponse 구조 사용)
      return UserModel(
        id: data['id'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        role: data['role'] ?? 'user',
        profile: UserProfileModel(
          // API는 full_name을 사용
          name: data['profile']?['full_name'] ?? data['username'] ?? '',
          profileImageUrl: data['profile']?['profile_image'],
          // API 스펙에는 없는 필드들 - null 처리
          dateOfBirth: null,
          phone: null,
          bio: data['profile']?['bio'],
          nationality: null,
          targetScore: null,
          currentLevel: null,
          interests: [],
        ),
        stats: UserStatsModel(
          // API 스펙의 stats는 additionalProperties 타입이므로 안전하게 처리
          totalTestsTaken:
              (data['stats'] as Map<String, dynamic>?)?['totalTestsTaken'] ?? 0,
          averageScore:
              (data['stats'] as Map<String, dynamic>?)?['averageScore'] ?? 0,
          bestScore:
              (data['stats'] as Map<String, dynamic>?)?['bestScore'] ?? 0,
          partScores: {},
          studyStreak:
              (data['stats'] as Map<String, dynamic>?)?['studyStreak'] ?? 0,
          totalStudyTime:
              (data['stats'] as Map<String, dynamic>?)?['totalStudyTime'] ?? 0,
          lastTestDate: null,
          lastStudyDate: null,
        ),
        subscription: UserSubscriptionModel(
          // API 스펙의 subscription도 additionalProperties 타입
          type:
              (data['subscription'] as Map<String, dynamic>?)?['type'] ??
              'free',
          startDate: null,
          endDate: null,
          isActive:
              (data['subscription'] as Map<String, dynamic>?)?['isActive'] ??
              false,
          paymentMethod: null,
          features:
              (data['subscription'] as Map<String, dynamic>?)?['features']
                  as Map<String, dynamic>? ??
              {},
        ),
        createdAt: data['created_at'] != null
            ? DateTime.tryParse(data['created_at'])
            : null,
        updatedAt: data['updated_at'] != null
            ? DateTime.tryParse(data['updated_at'])
            : null,
      );
    } on DioException catch (e) {
      debugPrint('❌ getCurrentUser DioException: ${e.toString()}');
      debugPrint('   Status Code: ${e.response?.statusCode}');
      debugPrint('   Response Data: ${e.response?.data}');
      throw _handleDioException(e);
    } catch (e) {
      debugPrint('❌ getCurrentUser Exception: ${e.toString()}');
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _apiClient.post(ApiEndpoints.resetPassword, data: {'email': email});
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> updateProfile({
    String? name,
    String? profileImageUrl,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (profileImageUrl != null) data['profile_image_url'] = profileImageUrl;

      final response = await _apiClient.put(
        ApiEndpoints.updateProfile,
        data: data,
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  ServerException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerException(message: 'Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Server error';

        switch (statusCode) {
          case 400:
            return ServerException(message: message, statusCode: statusCode);
          case 401:
            return ServerException(message: message, statusCode: statusCode);
          case 403:
            return ServerException(message: message, statusCode: statusCode);
          case 404:
            return ServerException(message: message, statusCode: statusCode);
          case 500:
            return ServerException(
              message: 'Internal server error',
              statusCode: statusCode,
            );
          default:
            return ServerException(message: message, statusCode: statusCode);
        }
      case DioExceptionType.cancel:
        return ServerException(message: 'Request cancelled');
      case DioExceptionType.connectionError:
        return ServerException(message: 'No internet connection');
      default:
        return ServerException(message: e.message ?? 'Unknown error');
    }
  }
}
