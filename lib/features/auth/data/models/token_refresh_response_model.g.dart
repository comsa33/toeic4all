// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_refresh_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRefreshResponseModel _$TokenRefreshResponseModelFromJson(
        Map<String, dynamic> json) =>
    TokenRefreshResponseModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String?,
      expiresIn: (json['expires_in'] as num?)?.toInt() ?? 3600,
    );

Map<String, dynamic> _$TokenRefreshResponseModelToJson(
        TokenRefreshResponseModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
    };
