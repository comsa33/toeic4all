// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiMetadataResponseImpl _$$ApiMetadataResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiMetadataResponseImpl(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ApiMetadataResponseImplToJson(
        _$ApiMetadataResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_$ApiSubtypesResponseImpl _$$ApiSubtypesResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiSubtypesResponseImpl(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$$ApiSubtypesResponseImplToJson(
        _$ApiSubtypesResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_$ApiErrorResponseImpl _$$ApiErrorResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiErrorResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      detail: json['detail'] as String?,
    );

Map<String, dynamic> _$$ApiErrorResponseImplToJson(
        _$ApiErrorResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'detail': instance.detail,
    };
