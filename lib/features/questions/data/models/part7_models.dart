import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/question.dart';

part 'part7_models.freezed.dart';
part 'part7_models.g.dart';

@freezed
class Part7SetModel with _$Part7SetModel {
  const factory Part7SetModel({
    required String id,
    required String difficulty,
    required String questionSetType,
    required List<Part7PassageModel> passages,
    required List<Part7QuestionModel> questions,
  }) = _Part7SetModel;

  factory Part7SetModel.fromJson(Map<String, dynamic> json) =>
      _$Part7SetModelFromJson(json);
}

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

@freezed
class Part7QuestionModel with _$Part7QuestionModel {
  const factory Part7QuestionModel({
    required int questionSeq,
    required String questionType,
    required String questionText,
    required String questionTranslation,
    required List<Part7ChoiceModel> choices,
  }) = _Part7QuestionModel;

  factory Part7QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$Part7QuestionModelFromJson(json);
}

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

@freezed
class Part7SetsResponseModel with _$Part7SetsResponseModel {
  const factory Part7SetsResponseModel({
    @Default(true) bool success,
    required int count,
    required int total,
    required int page,
    required int totalPages,
    required List<Part7SetModel> sets,
  }) = _Part7SetsResponseModel;

  factory Part7SetsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$Part7SetsResponseModelFromJson(json);
}

@freezed
class Part7AnswerModel with _$Part7AnswerModel {
  const factory Part7AnswerModel({
    required String setId,
    required int questionSeq,
    required String answer,
    required String explanation,
  }) = _Part7AnswerModel;

  factory Part7AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$Part7AnswerModelFromJson(json);
}

// Extensions to convert models to entities
extension Part7SetModelExt on Part7SetModel {
  Part7Set toEntity() {
    return Part7Set(
      id: id,
      difficulty: difficulty,
      questionSetType: questionSetType,
      passages: passages.map((p) => p.toEntity()).toList(),
      questions: questions.map((q) => q.toEntity()).toList(),
    );
  }
}

extension Part7PassageModelExt on Part7PassageModel {
  Part7Passage toEntity() {
    return Part7Passage(
      seq: seq,
      type: type,
      text: text,
      translation: translation,
    );
  }
}

extension Part7QuestionModelExt on Part7QuestionModel {
  Part7Question toEntity() {
    return Part7Question(
      questionSeq: questionSeq,
      questionType: questionType,
      questionText: questionText,
      questionTranslation: questionTranslation,
      choices: choices.map((c) => c.toEntity()).toList(),
    );
  }
}

extension Part7ChoiceModelExt on Part7ChoiceModel {
  Choice toEntity() {
    return Choice(
      id: id,
      text: text,
      translation: translation,
    );
  }
}

extension Part7AnswerModelExt on Part7AnswerModel {
  Part7Answer toEntity() {
    return Part7Answer(
      setId: setId,
      questionSeq: questionSeq,
      answer: answer,
      explanation: explanation,
    );
  }
}
