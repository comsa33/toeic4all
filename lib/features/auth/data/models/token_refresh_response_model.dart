import 'package:json_annotation/json_annotation.dart';
import '../../domain/repositories/auth_repository.dart';

part 'token_refresh_response_model.g.dart';

@JsonSerializable()
class TokenRefreshResponseModel {
  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(name: 'token_type')
  final String? tokenType;

  @JsonKey(name: 'expires_in')
  final int expiresIn;

  const TokenRefreshResponseModel({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType,
    this.expiresIn = 3600,
  });

  factory TokenRefreshResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenRefreshResponseModelToJson(this);
}

extension TokenRefreshResponseModelX on TokenRefreshResponseModel {
  Token toEntity() {
    return Token(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: DateTime.now().add(Duration(seconds: expiresIn)),
    );
  }
}
