import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/user.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'token_type') String? tokenType, // 추가
    @JsonKey(name: 'user_id') required String userId,
    required String username,
    required String email,
    required String role,
    @JsonKey(name: 'expires_in') @Default(3600) int expiresIn,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}

extension AuthResponseModelX on AuthResponseModel {
  AuthResponse toEntity() {
    // User 생성 시 name 필드에 username 사용
    final user = User(
      id: userId,
      username: username,
      email: email,
      role: role,
      profile: UserProfile(name: username), // username을 name으로 사용
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