import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_models.freezed.dart';
part 'common_models.g.dart';

// 메타데이터 응답 (categories, subtypes, difficulties 등)
@freezed
class ApiMetadataResponse with _$ApiMetadataResponse {
  const factory ApiMetadataResponse({
    @Default(true) bool success,
    String? message,
    required List<String> data,
  }) = _ApiMetadataResponse;

  factory ApiMetadataResponse.fromJson(Map<String, dynamic> json) {
    // API가 단순 문자열 배열만 반환하는 경우 처리
    if (json is List) {
      return ApiMetadataResponse(
        success: true,
        data: (json as List).map((item) => item.toString()).toList(),
      );
    }
    
    // API가 {"success": true, "data": [...]} 형태로 반환하는 경우 처리
    if (json is Map && json.containsKey('data')) {
      final data = json['data'];
      if (data is List) {
        return ApiMetadataResponse(
          success: json['success'] ?? true,
          message: json['message'] as String?,
          data: data.map((item) => item.toString()).toList(),
        );
      }
    }
    
    // 기본 freezed 파싱 사용
    return _$ApiMetadataResponseFromJson(json);
  }
}

// Part 5 서브타입을 위한 특별한 응답 (카테고리별 서브타입 반환)
@freezed
class ApiSubtypesResponse with _$ApiSubtypesResponse {
  const factory ApiSubtypesResponse({
    @Default(true) bool success,
    String? message,
    required dynamic data, // List<String> 또는 Map<String, List<String>>
  }) = _ApiSubtypesResponse;

  factory ApiSubtypesResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    
    if (data is List) {
      return ApiSubtypesResponse(
        success: json['success'] ?? true,
        message: json['message'] as String?,
        data: (data as List).map((item) => item.toString()).toList(),
      );
    } else if (data is Map) {
      return ApiSubtypesResponse(
        success: json['success'] ?? true,
        message: json['message'] as String?,
        data: Map<String, List<String>>.from(
          (data as Map).map((key, value) => MapEntry(
            key.toString(),
            (value as List).map((item) => item.toString()).toList(),
          )),
        ),
      );
    }
    
    return _$ApiSubtypesResponseFromJson(json);
  }
}

// Part 7 세트 타입 데이터
@freezed
class Part7SetTypesData with _$Part7SetTypesData {
  const factory Part7SetTypesData({
    required String description,
    @JsonKey(name: 'required_passages') required int requiredPassages,
  }) = _Part7SetTypesData;

  factory Part7SetTypesData.fromJson(Map<String, dynamic> json) =>
      _$Part7SetTypesDataFromJson(json);
}

// Part 7 세트 타입 응답
@freezed
class ApiSetTypesResponse with _$ApiSetTypesResponse {
  const factory ApiSetTypesResponse({
    @Default(true) bool success,
    String? message,
    required Map<String, Part7SetTypesData> data,
  }) = _ApiSetTypesResponse;

  factory ApiSetTypesResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiSetTypesResponseFromJson(json);
}

// 에러 응답
@freezed
class ApiErrorResponse with _$ApiErrorResponse {
  const factory ApiErrorResponse({
    required bool success,
    required String message,
    String? detail,
  }) = _ApiErrorResponse;

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);
}
