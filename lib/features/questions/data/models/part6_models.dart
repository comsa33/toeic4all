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

@freezed
class Part6SetsResponseModel with _$Part6SetsResponseModel {
  const factory Part6SetsResponseModel({
    @Default(true) bool success,
    required int count,
    required int total,
    required int page,
    required int totalPages,
    required List<Part6SetModel> sets,
  }) = _Part6SetsResponseModel;

  factory Part6SetsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$Part6SetsResponseModelFromJson(json);
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
