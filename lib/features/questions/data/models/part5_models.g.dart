// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part5_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChoiceModelImpl _$$ChoiceModelImplFromJson(Map<String, dynamic> json) =>
    _$ChoiceModelImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      translation: json['translation'] as String,
    );

Map<String, dynamic> _$$ChoiceModelImplToJson(_$ChoiceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'translation': instance.translation,
    };

_$Part5QuestionModelImpl _$$Part5QuestionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part5QuestionModelImpl(
      id: json['id'] as String,
      questionCategory: json['questionCategory'] as String,
      questionSubType: json['questionSubType'] as String,
      difficulty: json['difficulty'] as String,
      questionText: json['questionText'] as String,
      questionTranslation: json['questionTranslation'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Part5QuestionModelImplToJson(
        _$Part5QuestionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionCategory': instance.questionCategory,
      'questionSubType': instance.questionSubType,
      'difficulty': instance.difficulty,
      'questionText': instance.questionText,
      'questionTranslation': instance.questionTranslation,
      'choices': instance.choices,
    };

_$Part5QuestionsDataImpl _$$Part5QuestionsDataImplFromJson(
        Map<String, dynamic> json) =>
    _$Part5QuestionsDataImpl(
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Part5QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Part5QuestionsDataImplToJson(
        _$Part5QuestionsDataImpl instance) =>
    <String, dynamic>{
      'questions': instance.questions,
    };

_$Part5AnswerModelImpl _$$Part5AnswerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part5AnswerModelImpl(
      id: json['id'] as String,
      answer: json['answer'] as String,
      explanation: json['explanation'] as String,
      vocabulary: (json['vocabulary'] as List<dynamic>?)
          ?.map((e) => VocabularyItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Part5AnswerModelImplToJson(
        _$Part5AnswerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answer': instance.answer,
      'explanation': instance.explanation,
      'vocabulary': instance.vocabulary,
    };

_$Part5AnswerResponseModelImpl _$$Part5AnswerResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part5AnswerResponseModelImpl(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      data: Part5AnswerModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$Part5AnswerResponseModelImplToJson(
        _$Part5AnswerResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_$VocabularyItemModelImpl _$$VocabularyItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VocabularyItemModelImpl(
      word: json['word'] as String,
      meaning: json['meaning'] as String,
      partOfSpeech: json['partOfSpeech'] as String,
      example: json['example'] as String,
      exampleTranslation: json['exampleTranslation'] as String,
    );

Map<String, dynamic> _$$VocabularyItemModelImplToJson(
        _$VocabularyItemModelImpl instance) =>
    <String, dynamic>{
      'word': instance.word,
      'meaning': instance.meaning,
      'partOfSpeech': instance.partOfSpeech,
      'example': instance.example,
      'exampleTranslation': instance.exampleTranslation,
    };
