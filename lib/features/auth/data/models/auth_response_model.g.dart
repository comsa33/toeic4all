// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseModelImpl _$$AuthResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthResponseModelImpl(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String?,
      userId: json['user_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      loginProvider: json['login_provider'] as String? ?? 'username',
      expiresIn: (json['expires_in'] as num?)?.toInt() ?? 3600,
    );

Map<String, dynamic> _$$AuthResponseModelImplToJson(
        _$AuthResponseModelImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'user_id': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'role': instance.role,
      'login_provider': instance.loginProvider,
      'expires_in': instance.expiresIn,
    };
