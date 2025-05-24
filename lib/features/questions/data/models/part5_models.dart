import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/question.dart';

part 'part5_models.freezed.dart';
part 'part5_models.g.dart';

// Part 5 Choice Model
@freezed
class ChoiceModel with _$ChoiceModel {
  const factory ChoiceModel({
    required String id,
    required String text,
    required String translation,
  }) = _ChoiceModel;

  factory ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceModelFromJson(json);
}

// Part 5 Question Model  
@freezed
class Part5QuestionModel with _$Part5QuestionModel {
  const factory Part5QuestionModel({
    required String id,
    required String questionCategory,
    required String questionSubType,
    required String difficulty,
    required String questionText,
    required String questionTranslation,
    required List<ChoiceModel> choices,
  }) = _Part5QuestionModel;

  factory Part5QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$Part5QuestionModelFromJson(json);
}

// Part 5 Questions Data Structure
@freezed
class Part5QuestionsData with _$Part5QuestionsData {
  const factory Part5QuestionsData({
    required List<Part5QuestionModel> questions,
  }) = _Part5QuestionsData;

  factory Part5QuestionsData.fromJson(Map<String, dynamic> json) =>
      _$Part5QuestionsDataFromJson(json);
}

// Part 5 Questions Response Model - 수정: 필수 필드를 선택적으로 변경하고 기본값 제공
@freezed
class Part5QuestionsResponseModel with _$Part5QuestionsResponseModel {
  const factory Part5QuestionsResponseModel({
    @Default(true) bool success,
    String? message,
    required Part5QuestionsData data,
    @Default(0) int count,        // 수정: 기본값 제공
    @Default(0) int total,        // 수정: 기본값 제공
    @Default(1) int page,         // 수정: 기본값 제공
    @Default(1) int totalPages,   // 수정: 기본값 제공 (camelCase로 변경)
  }) = _Part5QuestionsResponseModel;

  // 수정: 커스텀 fromJson으로 안전한 파싱
  factory Part5QuestionsResponseModel.fromJson(Map<String, dynamic> json) {
    // 안전한 정수 파싱 함수
    int safeParseInt(dynamic value, int defaultValue) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value) ?? defaultValue;
      return defaultValue;
    }

    return Part5QuestionsResponseModel(
      success: json['success'] ?? true,
      message: json['message'],
      data: Part5QuestionsData.fromJson(json['data'] ?? {'questions': []}),
      count: safeParseInt(json['count'], (json['data']?['questions'] as List?)?.length ?? 0),
      total: safeParseInt(json['total'], (json['data']?['questions'] as List?)?.length ?? 0),
      page: safeParseInt(json['page'], 1),
      totalPages: safeParseInt(json['total_pages'] ?? json['totalPages'], 1),
    );
  }
}

// Part 5 Answer Model
@freezed
class Part5AnswerModel with _$Part5AnswerModel {
  const factory Part5AnswerModel({
    required String id,
    required String answer,
    required String explanation,
    List<VocabularyItemModel>? vocabulary,
  }) = _Part5AnswerModel;

  factory Part5AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$Part5AnswerModelFromJson(json);
}

// Part 5 Answer Response Model
@freezed
class Part5AnswerResponseModel with _$Part5AnswerResponseModel {
  const factory Part5AnswerResponseModel({
    @Default(true) bool success,
    String? message,
    required Part5AnswerModel data,
  }) = _Part5AnswerResponseModel;

  factory Part5AnswerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$Part5AnswerResponseModelFromJson(json);
}

// Vocabulary Item Model
@freezed
class VocabularyItemModel with _$VocabularyItemModel {
  const factory VocabularyItemModel({
    required String word,
    required String meaning,
    required String partOfSpeech,
    required String example,
    required String exampleTranslation,
  }) = _VocabularyItemModel;

  factory VocabularyItemModel.fromJson(Map<String, dynamic> json) =>
      _$VocabularyItemModelFromJson(json);
}

// Extensions to convert models to entities
extension ChoiceModelExt on ChoiceModel {
  Choice toEntity() {
    return Choice(
      id: id,
      text: text,
      translation: translation,
    );
  }
}

extension Part5QuestionModelExt on Part5QuestionModel {
  Part5Question toEntity() {
    return Part5Question(
      id: id,
      questionCategory: questionCategory,
      questionSubType: questionSubType,
      difficulty: difficulty,
      questionText: questionText,
      questionTranslation: questionTranslation,
      choices: choices.map((c) => c.toEntity()).toList(),
    );
  }
}

extension Part5AnswerModelExt on Part5AnswerModel {
  Part5Answer toEntity() {
    return Part5Answer(
      id: id,
      answer: answer,
      explanation: explanation,
      vocabulary: vocabulary?.map((v) => v.toEntity()).toList(),
    );
  }
}

extension VocabularyItemModelExt on VocabularyItemModel {
  VocabularyItem toEntity() {
    return VocabularyItem(
      word: word,
      meaning: meaning,
      partOfSpeech: partOfSpeech,
      example: example,
      exampleTranslation: exampleTranslation,
    );
  }
}
