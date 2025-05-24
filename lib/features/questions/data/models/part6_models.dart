import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/question.dart';

part 'part6_models.freezed.dart';
part 'part6_models.g.dart';

@freezed
class Part6SetModel with _$Part6SetModel {
  const factory Part6SetModel({
    required String id,
    required String passageType,
    required String difficulty,
    required String passage,
    required String passageTranslation,
    required List<Part6QuestionModel> questions,
  }) = _Part6SetModel;

  factory Part6SetModel.fromJson(Map<String, dynamic> json) =>
      _$Part6SetModelFromJson(json);
}

@freezed
class Part6QuestionModel with _$Part6QuestionModel {
  const factory Part6QuestionModel({
    required int blankNumber,
    required String questionType,
    required List<Part6ChoiceModel> choices,
  }) = _Part6QuestionModel;

  factory Part6QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$Part6QuestionModelFromJson(json);
}

@freezed
class Part6ChoiceModel with _$Part6ChoiceModel {
  const factory Part6ChoiceModel({
    required String id,
    required String text,
    required String translation,
  }) = _Part6ChoiceModel;

  factory Part6ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$Part6ChoiceModelFromJson(json);
}

// Part 6 세트 목록 데이터 구조
@freezed
class Part6SetsData with _$Part6SetsData {
  const factory Part6SetsData({
    required List<Part6SetModel> sets,
  }) = _Part6SetsData;

  factory Part6SetsData.fromJson(Map<String, dynamic> json) =>
      _$Part6SetsDataFromJson(json);
}

// Part 6 세트 목록 응답 구조 - 수정: 안전한 파싱 적용
@freezed
class Part6SetsResponseModel with _$Part6SetsResponseModel {
  const factory Part6SetsResponseModel({
    @Default(true) bool success,
    String? message,
    required Part6SetsData data,
    @Default(0) int count,        // 수정: 기본값 제공
    @Default(0) int total,        // 수정: 기본값 제공
    @Default(1) int page,         // 수정: 기본값 제공
    @Default(1) int totalPages,   // 수정: 기본값 제공
  }) = _Part6SetsResponseModel;

  // 수정: 커스텀 fromJson으로 안전한 파싱
  factory Part6SetsResponseModel.fromJson(Map<String, dynamic> json) {
    // 안전한 정수 파싱 함수
    int safeParseInt(dynamic value, int defaultValue) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? defaultValue;
      return defaultValue;
    }

    return Part6SetsResponseModel(
      success: json['success'] ?? true,
      message: json['message'],
      data: Part6SetsData.fromJson(json['data'] ?? {'sets': []}),
      count: safeParseInt(json['count'], (json['data']?['sets'] as List?)?.length ?? 0),
      total: safeParseInt(json['total'], (json['data']?['sets'] as List?)?.length ?? 0),
      page: safeParseInt(json['page'], 1),
      totalPages: safeParseInt(json['total_pages'] ?? json['totalPages'], 1),
    );
  }
}

// Part 6 정답 데이터 구조
@freezed
class Part6AnswerData with _$Part6AnswerData {
  const factory Part6AnswerData({
    @JsonKey(name: 'set_id') required String setId,
    @JsonKey(name: 'question_seq') required int questionSeq,
    required String answer,
    required String explanation,
  }) = _Part6AnswerData;

  factory Part6AnswerData.fromJson(Map<String, dynamic> json) =>
      _$Part6AnswerDataFromJson(json);
}

// Part 6 정답 응답 구조
@freezed
class Part6AnswerResponseModel with _$Part6AnswerResponseModel {
  const factory Part6AnswerResponseModel({
    @Default(true) bool success,
    String? message,
    required Part6AnswerData data,
  }) = _Part6AnswerResponseModel;

  factory Part6AnswerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$Part6AnswerResponseModelFromJson(json);
}

@freezed
class Part6AnswerModel with _$Part6AnswerModel {
  const factory Part6AnswerModel({
    required String setId,
    required int questionSeq,
    required String answer,
    required String explanation,
  }) = _Part6AnswerModel;

  factory Part6AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$Part6AnswerModelFromJson(json);
}

// Extensions to convert models to entities
extension Part6SetModelExt on Part6SetModel {
  Part6Set toEntity() {
    return Part6Set(
      id: id,
      passageType: passageType,
      difficulty: difficulty,
      passage: passage,
      passageTranslation: passageTranslation,
      questions: questions.map((q) => q.toEntity()).toList(),
    );
  }
}

extension Part6QuestionModelExt on Part6QuestionModel {
  Part6Question toEntity() {
    return Part6Question(
      blankNumber: blankNumber,
      questionType: questionType,
      choices: choices.map((c) => c.toEntity()).toList(),
    );
  }
}

extension Part6ChoiceModelExt on Part6ChoiceModel {
  Choice toEntity() {
    return Choice(
      id: id,
      text: text,
      translation: translation,
    );
  }
}

extension Part6AnswerModelExt on Part6AnswerModel {
  Part6Answer toEntity() {
    return Part6Answer(
      setId: setId,
      questionSeq: questionSeq,
      answer: answer,
      explanation: explanation,
    );
  }
}

extension Part6AnswerDataExt on Part6AnswerData {
  Part6Answer toEntity() {
    return Part6Answer(
      setId: setId,
      questionSeq: questionSeq,
      answer: answer,
      explanation: explanation,
    );
  }
}
