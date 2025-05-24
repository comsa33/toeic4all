import 'package:freezed_annotation/freezed_annotation.dart';
// domain entities import - question.dart 파일 사용
import '../../domain/entities/question.dart';

part 'part7_models.freezed.dart';
part 'part7_models.g.dart';

// Part 7 Choice Model
@freezed
class Part7ChoiceModel with _$Part7ChoiceModel {
  const factory Part7ChoiceModel({
    required String id,
    required String text,
    required String translation,
  }) = _Part7ChoiceModel;

  factory Part7ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$Part7ChoiceModelFromJson(json);
}

// Part 7 Choice extension for entity conversion - 공통 Choice 클래스 사용
extension Part7ChoiceModelX on Part7ChoiceModel {
  Choice toEntity() {
    return Choice(
      id: id,
      text: text,
      translation: translation,
    );
  }
}

// Part 7 Passage Model
@freezed
class Part7PassageModel with _$Part7PassageModel {
  const factory Part7PassageModel({
    required int seq,
    required String type,
    required String text,
    required String translation,
  }) = _Part7PassageModel;

  factory Part7PassageModel.fromJson(Map<String, dynamic> json) =>
      _$Part7PassageModelFromJson(json);
}

// Part 7 Passage extension for entity conversion
extension Part7PassageModelX on Part7PassageModel {
  Part7Passage toEntity() {
    return Part7Passage(
      seq: seq,
      type: type,
      text: text,
      translation: translation,
    );
  }
}

// Part 7 Question Model
@freezed
class Part7QuestionModel with _$Part7QuestionModel {
  const factory Part7QuestionModel({
    @JsonKey(name: 'questionSeq') required int questionSeq,
    @JsonKey(name: 'questionType') required String questionType,
    @JsonKey(name: 'questionText') required String questionText,
    @JsonKey(name: 'questionTranslation') required String questionTranslation,
    required List<Part7ChoiceModel> choices,
  }) = _Part7QuestionModel;

  factory Part7QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$Part7QuestionModelFromJson(json);
}

// Part 7 Question extension for entity conversion
extension Part7QuestionModelX on Part7QuestionModel {
  Part7Question toEntity() {
    return Part7Question(
      questionSeq: questionSeq,
      questionType: questionType,
      questionText: questionText,
      questionTranslation: questionTranslation,
      choices: choices.map((choice) => choice.toEntity()).toList(),
    );
  }
}

// Part 7 Set Model
@freezed
class Part7SetModel with _$Part7SetModel {
  const factory Part7SetModel({
    required String id,
    required String difficulty,
    @JsonKey(name: 'questionSetType') required String questionSetType,
    required List<Part7PassageModel> passages,
    required List<Part7QuestionModel> questions,
  }) = _Part7SetModel;

  factory Part7SetModel.fromJson(Map<String, dynamic> json) =>
      _$Part7SetModelFromJson(json);
}

// Part 7 Set extension for entity conversion
extension Part7SetModelX on Part7SetModel {
  Part7Set toEntity() {
    return Part7Set(
      id: id,
      difficulty: difficulty,
      questionSetType: questionSetType,
      passages: passages.map((passage) => passage.toEntity()).toList(),
      questions: questions.map((question) => question.toEntity()).toList(),
    );
  }
}

// Part 7 Sets Data Wrapper
@freezed
class Part7SetsData with _$Part7SetsData {
  const factory Part7SetsData({
    required List<Part7SetModel> sets,
  }) = _Part7SetsData;

  factory Part7SetsData.fromJson(Map<String, dynamic> json) =>
      _$Part7SetsDataFromJson(json);
}

// Part 7 Sets Response Model
@freezed
class Part7SetsResponseModel with _$Part7SetsResponseModel {
  const factory Part7SetsResponseModel({
    required bool success,
    required String message,
    required Part7SetsData data,
    required int count,
    required int total,
    required int page,
    @JsonKey(name: 'total_pages') required int totalPages,
  }) = _Part7SetsResponseModel;

  factory Part7SetsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$Part7SetsResponseModelFromJson(json);
}

// Part 7 Answer Data
@freezed
class Part7AnswerData with _$Part7AnswerData {
  const factory Part7AnswerData({
    @JsonKey(name: 'set_id') required String setId,
    @JsonKey(name: 'question_seq') required int questionSeq,
    required String answer,
    required String explanation,
  }) = _Part7AnswerData;

  factory Part7AnswerData.fromJson(Map<String, dynamic> json) =>
      _$Part7AnswerDataFromJson(json);
}

// Part 7 Answer Data extension for entity conversion
extension Part7AnswerDataX on Part7AnswerData {
  Part7Answer toEntity() {
    return Part7Answer(
      setId: setId,
      questionSeq: questionSeq,
      answer: answer,
      explanation: explanation,
    );
  }
}

// Part 7 Answer Response Model
@freezed
class Part7AnswerResponseModel with _$Part7AnswerResponseModel {
  const factory Part7AnswerResponseModel({
    required bool success,
    required String message,
    required Part7AnswerData data,
  }) = _Part7AnswerResponseModel;

  factory Part7AnswerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$Part7AnswerResponseModelFromJson(json);
}

// Part 7 Set Type Details Model (백엔드 API의 SetTypeInfo와 일치)
@freezed
class SetTypeInfoModel with _$SetTypeInfoModel {
  const factory SetTypeInfoModel({
    required String description,
    @JsonKey(name: 'required_passages') required int requiredPassages,
  }) = _SetTypeInfoModel;

  factory SetTypeInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SetTypeInfoModelFromJson(json);
}

// Part 7 Set Types Response Model - 직접 Map<String, SetTypeInfoModel> 사용
@freezed
class Part7SetTypesResponseModel with _$Part7SetTypesResponseModel {
  const factory Part7SetTypesResponseModel({
    required bool success,
    required String message,
    required Map<String, SetTypeInfoModel> data,
  }) = _Part7SetTypesResponseModel;

  factory Part7SetTypesResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final convertedData = <String, SetTypeInfoModel>{};
    
    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        convertedData[key] = SetTypeInfoModel.fromJson(value);
      }
    });
    
    return Part7SetTypesResponseModel(
      success: json['success'] ?? true,
      message: json['message'] ?? '',
      data: convertedData,
    );
  }
}

// Part 7 Passage Combinations Response Model
@freezed
class Part7PassageCombinationsResponseModel with _$Part7PassageCombinationsResponseModel {
  const factory Part7PassageCombinationsResponseModel({
    required bool success,
    required String message,
    required List<List<String>> data,
  }) = _Part7PassageCombinationsResponseModel;

  factory Part7PassageCombinationsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$Part7PassageCombinationsResponseModelFromJson(json);
}
