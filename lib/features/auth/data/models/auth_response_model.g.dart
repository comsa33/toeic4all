// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseModelImpl _$$AuthResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthResponseModelImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      userId: json['user_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      expiresIn: (json['expiresIn'] as num?)?.toInt() ?? 3600,
    );

Map<String, dynamic> _$$AuthResponseModelImplToJson(
        _$AuthResponseModelImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user_id': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'role': instance.role,
      'expiresIn': instance.expiresIn,
    };
