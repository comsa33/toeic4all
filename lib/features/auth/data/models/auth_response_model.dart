import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/user.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    required String accessToken,
    required String refreshToken,
    @JsonKey(name: 'user_id') required String userId,
    required String username,
    required String email,
    required String role,
    @Default(3600) int expiresIn,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}

extension AuthResponseModelX on AuthResponseModel {
  AuthResponse toEntity() {
    // Create a basic User entity from the auth response data
    final user = User(
      id: userId,
      username: username,
      email: email,
      role: role,
      profile: const UserProfile(name: ''), // Will be filled from user profile endpoint
      stats: const UserStats(),
      subscription: const UserSubscription(),
    );

    return AuthResponse(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user,
      expiresIn: expiresIn,
    );
  }
}

extension AuthResponseX on AuthResponse {
  AuthResponseModel toModel() {
    return AuthResponseModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      userId: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
      expiresIn: expiresIn,
    );
  }
}
