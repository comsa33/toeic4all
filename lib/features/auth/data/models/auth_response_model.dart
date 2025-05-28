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
    @JsonKey(name: 'token_type') String? tokenType,
    @JsonKey(name: 'user_id') required String userId,
    required String username,
    required String email,
    required String role,
    @JsonKey(name: 'login_provider') @Default('username') String loginProvider,
    @JsonKey(name: 'expires_in') @Default(3600) int expiresIn,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}

extension AuthResponseModelX on AuthResponseModel {
  AuthResponse toEntity() {
    // String을 LoginProvider enum으로 변환
    LoginProvider provider;
    switch (loginProvider.toLowerCase()) {
      case 'google':
        provider = LoginProvider.google;
        break;
      case 'kakao':
        provider = LoginProvider.kakao;
        break;
      case 'naver':
        provider = LoginProvider.naver;
        break;
      default:
        provider = LoginProvider.username;
    }

    // User 생성 시 name 필드에 username 사용
    final user = User(
      id: userId,
      username: username,
      email: email,
      role: role,
      profile: UserProfile(name: username), // username을 name으로 사용
      stats: const UserStats(),
      subscription: const UserSubscription(),
      loginProvider: provider,
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
    // LoginProvider enum을 String으로 변환
    String providerString;
    switch (user.loginProvider) {
      case LoginProvider.google:
        providerString = 'google';
        break;
      case LoginProvider.kakao:
        providerString = 'kakao';
        break;
      case LoginProvider.naver:
        providerString = 'naver';
        break;
      case LoginProvider.username:
        providerString = 'username';
        break;
    }

    return AuthResponseModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      userId: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
      loginProvider: providerString,
      expiresIn: expiresIn,
    );
  }
}