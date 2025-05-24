// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Part5QuestionModelImpl _$$Part5QuestionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part5QuestionModelImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctAnswer: (json['correctAnswer'] as num).toInt(),
      explanation: json['explanation'] as String,
      difficulty: json['difficulty'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$Part5QuestionModelImplToJson(
        _$Part5QuestionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'choices': instance.choices,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
      'difficulty': instance.difficulty,
      'tags': instance.tags,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$Part6QuestionSetModelImpl _$$Part6QuestionSetModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part6QuestionSetModelImpl(
      id: json['id'] as String,
      passage: json['passage'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Part6QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      difficulty: json['difficulty'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$Part6QuestionSetModelImplToJson(
        _$Part6QuestionSetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'passage': instance.passage,
      'questions': instance.questions,
      'difficulty': instance.difficulty,
      'tags': instance.tags,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$Part6QuestionModelImpl _$$Part6QuestionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part6QuestionModelImpl(
      questionNumber: (json['questionNumber'] as num).toInt(),
      text: json['text'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctAnswer: (json['correctAnswer'] as num).toInt(),
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$$Part6QuestionModelImplToJson(
        _$Part6QuestionModelImpl instance) =>
    <String, dynamic>{
      'questionNumber': instance.questionNumber,
      'text': instance.text,
      'choices': instance.choices,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
    };

_$Part7QuestionSetModelImpl _$$Part7QuestionSetModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part7QuestionSetModelImpl(
      id: json['id'] as String,
      passage: json['passage'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Part7QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      difficulty: json['difficulty'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$Part7QuestionSetModelImplToJson(
        _$Part7QuestionSetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'passage': instance.passage,
      'questions': instance.questions,
      'difficulty': instance.difficulty,
      'tags': instance.tags,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$Part7QuestionModelImpl _$$Part7QuestionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part7QuestionModelImpl(
      questionNumber: (json['questionNumber'] as num).toInt(),
      text: json['text'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctAnswer: (json['correctAnswer'] as num).toInt(),
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$$Part7QuestionModelImplToJson(
        _$Part7QuestionModelImpl instance) =>
    <String, dynamic>{
      'questionNumber': instance.questionNumber,
      'text': instance.text,
      'choices': instance.choices,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
    };

_$ChoiceModelImpl _$$ChoiceModelImplFromJson(Map<String, dynamic> json) =>
    _$ChoiceModelImpl(
      text: json['text'] as String,
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$$ChoiceModelImplToJson(_$ChoiceModelImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'explanation': instance.explanation,
    };

_$VocabularyModelImpl _$$VocabularyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VocabularyModelImpl(
      id: json['id'] as String,
      word: json['word'] as String,
      meaning: json['meaning'] as String,
      pronunciation: json['pronunciation'] as String,
      partOfSpeech: json['partOfSpeech'] as String,
      examples: (json['examples'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      difficulty: json['difficulty'] as String,
      synonyms: (json['synonyms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      antonyms: (json['antonyms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$VocabularyModelImplToJson(
        _$VocabularyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'meaning': instance.meaning,
      'pronunciation': instance.pronunciation,
      'partOfSpeech': instance.partOfSpeech,
      'examples': instance.examples,
      'difficulty': instance.difficulty,
      'synonyms': instance.synonyms,
      'antonyms': instance.antonyms,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
