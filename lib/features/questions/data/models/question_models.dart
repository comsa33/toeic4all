import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/questions.dart';

part 'question_models.freezed.dart';
part 'question_models.g.dart';

@freezed
class Part5QuestionModel with _$Part5QuestionModel {
  const factory Part5QuestionModel({
    required String id,
    required String text,
    required List<ChoiceModel> choices,
    required int correctAnswer,
    required String explanation,
    required String difficulty,
    @Default([]) List<String> tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Part5QuestionModel;

  factory Part5QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$Part5QuestionModelFromJson(json);
}

@freezed
class Part6QuestionSetModel with _$Part6QuestionSetModel {
  const factory Part6QuestionSetModel({
    required String id,
    required String passage,
    required List<Part6QuestionModel> questions,
    required String difficulty,
    @Default([]) List<String> tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Part6QuestionSetModel;

  factory Part6QuestionSetModel.fromJson(Map<String, dynamic> json) =>
      _$Part6QuestionSetModelFromJson(json);
}

@freezed
class Part6QuestionModel with _$Part6QuestionModel {
  const factory Part6QuestionModel({
    required int questionNumber,
    required String text,
    required List<ChoiceModel> choices,
    required int correctAnswer,
    required String explanation,
  }) = _Part6QuestionModel;

  factory Part6QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$Part6QuestionModelFromJson(json);
}

@freezed
class Part7QuestionSetModel with _$Part7QuestionSetModel {
  const factory Part7QuestionSetModel({
    required String id,
    required String passage,
    required List<Part7QuestionModel> questions,
    required String difficulty,
    @Default([]) List<String> tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Part7QuestionSetModel;

  factory Part7QuestionSetModel.fromJson(Map<String, dynamic> json) =>
      _$Part7QuestionSetModelFromJson(json);
}

@freezed
class Part7QuestionModel with _$Part7QuestionModel {
  const factory Part7QuestionModel({
    required int questionNumber,
    required String text,
    required List<ChoiceModel> choices,
    required int correctAnswer,
    required String explanation,
  }) = _Part7QuestionModel;

  factory Part7QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$Part7QuestionModelFromJson(json);
}

@freezed
class ChoiceModel with _$ChoiceModel {
  const factory ChoiceModel({
    required String text,
    String? explanation,
  }) = _ChoiceModel;

  factory ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceModelFromJson(json);
}

@freezed
class VocabularyModel with _$VocabularyModel {
  const factory VocabularyModel({
    required String id,
    required String word,
    required String meaning,
    required String pronunciation,
    required String partOfSpeech,
    @Default([]) List<String> examples,
    required String difficulty,
    @Default([]) List<String> synonyms,
    @Default([]) List<String> antonyms,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _VocabularyModel;

  factory VocabularyModel.fromJson(Map<String, dynamic> json) =>
      _$VocabularyModelFromJson(json);
}

// Extension methods for converting between models and entities
extension Part5QuestionModelX on Part5QuestionModel {
  Part5Question toEntity() {
    return Part5Question(
      id: id,
      text: text,
      choices: choices.map((c) => c.toEntity()).toList(),
      correctAnswer: correctAnswer,
      explanation: explanation,
      difficulty: difficulty,
      tags: tags,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension Part6QuestionSetModelX on Part6QuestionSetModel {
  Part6QuestionSet toEntity() {
    return Part6QuestionSet(
      id: id,
      passage: passage,
      questions: questions.map((q) => q.toEntity()).toList(),
      difficulty: difficulty,
      tags: tags,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension Part6QuestionModelX on Part6QuestionModel {
  Part6Question toEntity() {
    return Part6Question(
      questionNumber: questionNumber,
      text: text,
      choices: choices.map((c) => c.toEntity()).toList(),
      correctAnswer: correctAnswer,
      explanation: explanation,
    );
  }
}

extension Part7QuestionSetModelX on Part7QuestionSetModel {
  Part7QuestionSet toEntity() {
    return Part7QuestionSet(
      id: id,
      passage: passage,
      questions: questions.map((q) => q.toEntity()).toList(),
      difficulty: difficulty,
      tags: tags,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension Part7QuestionModelX on Part7QuestionModel {
  Part7Question toEntity() {
    return Part7Question(
      questionNumber: questionNumber,
      text: text,
      choices: choices.map((c) => c.toEntity()).toList(),
      correctAnswer: correctAnswer,
      explanation: explanation,
    );
  }
}

extension ChoiceModelX on ChoiceModel {
  Choice toEntity() {
    return Choice(
      text: text,
      explanation: explanation,
    );
  }
}

extension VocabularyModelX on VocabularyModel {
  Vocabulary toEntity() {
    return Vocabulary(
      id: id,
      word: word,
      meaning: meaning,
      pronunciation: pronunciation,
      partOfSpeech: partOfSpeech,
      examples: examples,
      difficulty: difficulty,
      synonyms: synonyms,
      antonyms: antonyms,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

// Entity to Model extensions
extension Part5QuestionX on Part5Question {
  Part5QuestionModel toModel() {
    return Part5QuestionModel(
      id: id,
      text: text,
      choices: choices.map((c) => c.toModel()).toList(),
      correctAnswer: correctAnswer,
      explanation: explanation,
      difficulty: difficulty,
      tags: tags,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension Part6QuestionSetX on Part6QuestionSet {
  Part6QuestionSetModel toModel() {
    return Part6QuestionSetModel(
      id: id,
      passage: passage,
      questions: questions.map((q) => q.toModel()).toList(),
      difficulty: difficulty,
      tags: tags,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension Part6QuestionX on Part6Question {
  Part6QuestionModel toModel() {
    return Part6QuestionModel(
      questionNumber: questionNumber,
      text: text,
      choices: choices.map((c) => c.toModel()).toList(),
      correctAnswer: correctAnswer,
      explanation: explanation,
    );
  }
}

extension Part7QuestionSetX on Part7QuestionSet {
  Part7QuestionSetModel toModel() {
    return Part7QuestionSetModel(
      id: id,
      passage: passage,
      questions: questions.map((q) => q.toModel()).toList(),
      difficulty: difficulty,
      tags: tags,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension Part7QuestionX on Part7Question {
  Part7QuestionModel toModel() {
    return Part7QuestionModel(
      questionNumber: questionNumber,
      text: text,
      choices: choices.map((c) => c.toModel()).toList(),
      correctAnswer: correctAnswer,
      explanation: explanation,
    );
  }
}

extension ChoiceX on Choice {
  ChoiceModel toModel() {
    return ChoiceModel(
      text: text,
      explanation: explanation,
    );
  }
}

extension VocabularyX on Vocabulary {
  VocabularyModel toModel() {
    return VocabularyModel(
      id: id,
      word: word,
      meaning: meaning,
      pronunciation: pronunciation,
      partOfSpeech: partOfSpeech,
      examples: examples,
      difficulty: difficulty,
      synonyms: synonyms,
      antonyms: antonyms,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
