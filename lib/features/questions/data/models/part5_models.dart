import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/question.dart';

part 'part5_models.freezed.dart';
part 'part5_models.g.dart';

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

@freezed
class Part5QuestionsResponseModel with _$Part5QuestionsResponseModel {
  const factory Part5QuestionsResponseModel({
    @Default(true) bool success,
    required int count,
    required int total,
    required int page,
    required int totalPages,
    required List<Part5QuestionModel> questions,
  }) = _Part5QuestionsResponseModel;

  factory Part5QuestionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$Part5QuestionsResponseModelFromJson(json);
}

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

extension ChoiceModelExt on ChoiceModel {
  Choice toEntity() {
    return Choice(
      id: id,
      text: text,
      translation: translation,
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
