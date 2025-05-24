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

  factory ApiMetadataResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiMetadataResponseFromJson(json);
}

// Part 5 서브타입을 위한 특별한 응답 (카테고리별 서브타입 반환 가능)
@freezed
class ApiSubtypesResponse with _$ApiSubtypesResponse {
  const factory ApiSubtypesResponse({
    @Default(true) bool success,
    String? message,
    required dynamic data, // List<String> 또는 Map<String, List<String>>
  }) = _ApiSubtypesResponse;

  factory ApiSubtypesResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiSubtypesResponseFromJson(json);
}

// Part 7 세트 타입 정보 (part7_models.dart로 이동됨)
// SetTypeInfo는 part7_models.dart의 SetTypeInfoModel 사용

// Part 7 지문 조합 응답 (part7_models.dart로 이동됨)
// Part7PassageCombinationsResponseModel은 part7_models.dart 사용

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
