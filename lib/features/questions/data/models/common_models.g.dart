// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Part7SetTypesDataImpl _$$Part7SetTypesDataImplFromJson(
        Map<String, dynamic> json) =>
    _$Part7SetTypesDataImpl(
      description: json['description'] as String,
      requiredPassages: (json['required_passages'] as num).toInt(),
    );

Map<String, dynamic> _$$Part7SetTypesDataImplToJson(
        _$Part7SetTypesDataImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'required_passages': instance.requiredPassages,
    };

_$ApiSetTypesResponseImpl _$$ApiSetTypesResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ApiSetTypesResponseImpl(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, Part7SetTypesData.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$ApiSetTypesResponseImplToJson(
        _$ApiSetTypesResponseImpl instance) =>
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
