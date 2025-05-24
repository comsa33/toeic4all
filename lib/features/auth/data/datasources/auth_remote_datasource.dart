import 'package:dio/dio.dart';
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
  Future<UserModel> updateProfile({
    String? name,
    String? profileImageUrl,
  });
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
        data: {
          'username': username,
          'password': password,
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
        queryParameters: {
          'code': code,
          'redirect_uri': redirectUri,
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
        queryParameters: {
          'code': code,
          'redirect_uri': redirectUri,
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
      
      // Create a complete UserModel with default values for missing fields
      return UserModel(
        id: data['id'] ?? data['_id'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        role: data['role'] ?? 'user',
        profile: UserProfileModel(
          name: data['name'] ?? data['profile']?['name'] ?? '',
          profileImageUrl: data['profile_image_url'] ?? data['profile']?['profileImageUrl'],
          dateOfBirth: data['profile']?['dateOfBirth'] != null 
              ? DateTime.tryParse(data['profile']['dateOfBirth']) 
              : null,
          phone: data['profile']?['phone'],
          bio: data['profile']?['bio'],
          nationality: data['profile']?['nationality'],
          targetScore: data['profile']?['targetScore'],
          currentLevel: data['profile']?['currentLevel'],
          interests: List<String>.from(data['profile']?['interests'] ?? []),
        ),
        stats: UserStatsModel(
          totalTestsTaken: data['stats']?['totalTestsTaken'] ?? 0,
          averageScore: data['stats']?['averageScore'] ?? 0,
          bestScore: data['stats']?['bestScore'] ?? 0,
          partScores: Map<String, int>.from(data['stats']?['partScores'] ?? {}),
          studyStreak: data['stats']?['studyStreak'] ?? 0,
          totalStudyTime: data['stats']?['totalStudyTime'] ?? 0,
          lastTestDate: data['stats']?['lastTestDate'] != null 
              ? DateTime.tryParse(data['stats']['lastTestDate']) 
              : null,
          lastStudyDate: data['stats']?['lastStudyDate'] != null 
              ? DateTime.tryParse(data['stats']['lastStudyDate']) 
              : null,
        ),
        subscription: UserSubscriptionModel(
          type: data['subscription']?['type'] ?? 'free',
          startDate: data['subscription']?['startDate'] != null 
              ? DateTime.tryParse(data['subscription']['startDate']) 
              : null,
          endDate: data['subscription']?['endDate'] != null 
              ? DateTime.tryParse(data['subscription']['endDate']) 
              : null,
          isActive: data['subscription']?['isActive'] ?? false,
          paymentMethod: data['subscription']?['paymentMethod'],
          features: Map<String, dynamic>.from(data['subscription']?['features'] ?? {}),
        ),
        createdAt: data['created_at'] != null || data['createdAt'] != null 
            ? DateTime.tryParse(data['created_at'] ?? data['createdAt']) 
            : null,
        updatedAt: data['updated_at'] != null || data['updatedAt'] != null 
            ? DateTime.tryParse(data['updated_at'] ?? data['updatedAt']) 
            : null,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _apiClient.post(
        ApiEndpoints.resetPassword,
        data: {'email': email},
      );
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
            return ServerException(message: 'Internal server error', statusCode: statusCode);
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
