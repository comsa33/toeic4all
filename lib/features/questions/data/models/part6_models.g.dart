// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part6_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Part6SetModelImpl _$$Part6SetModelImplFromJson(Map<String, dynamic> json) =>
    _$Part6SetModelImpl(
      id: json['id'] as String,
      passageType: json['passageType'] as String,
      difficulty: json['difficulty'] as String,
      passage: json['passage'] as String,
      passageTranslation: json['passageTranslation'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Part6QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Part6SetModelImplToJson(_$Part6SetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'passageType': instance.passageType,
      'difficulty': instance.difficulty,
      'passage': instance.passage,
      'passageTranslation': instance.passageTranslation,
      'questions': instance.questions,
    };

_$Part6QuestionModelImpl _$$Part6QuestionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part6QuestionModelImpl(
      blankNumber: (json['blankNumber'] as num).toInt(),
      questionType: json['questionType'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => Part6ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Part6QuestionModelImplToJson(
        _$Part6QuestionModelImpl instance) =>
    <String, dynamic>{
      'blankNumber': instance.blankNumber,
      'questionType': instance.questionType,
      'choices': instance.choices,
    };

_$Part6ChoiceModelImpl _$$Part6ChoiceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part6ChoiceModelImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      translation: json['translation'] as String,
    );

Map<String, dynamic> _$$Part6ChoiceModelImplToJson(
        _$Part6ChoiceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'translation': instance.translation,
    };

_$Part6SetsDataImpl _$$Part6SetsDataImplFromJson(Map<String, dynamic> json) =>
    _$Part6SetsDataImpl(
      sets: (json['sets'] as List<dynamic>)
          .map((e) => Part6SetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Part6SetsDataImplToJson(_$Part6SetsDataImpl instance) =>
    <String, dynamic>{
      'sets': instance.sets,
    };

_$Part6AnswerDataImpl _$$Part6AnswerDataImplFromJson(
        Map<String, dynamic> json) =>
    _$Part6AnswerDataImpl(
      setId: json['set_id'] as String,
      questionSeq: (json['question_seq'] as num).toInt(),
      answer: json['answer'] as String,
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$$Part6AnswerDataImplToJson(
        _$Part6AnswerDataImpl instance) =>
    <String, dynamic>{
      'set_id': instance.setId,
      'question_seq': instance.questionSeq,
      'answer': instance.answer,
      'explanation': instance.explanation,
    };

_$Part6AnswerResponseModelImpl _$$Part6AnswerResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part6AnswerResponseModelImpl(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      data: Part6AnswerData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$Part6AnswerResponseModelImplToJson(
        _$Part6AnswerResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_$Part6AnswerModelImpl _$$Part6AnswerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part6AnswerModelImpl(
      setId: json['setId'] as String,
      questionSeq: (json['questionSeq'] as num).toInt(),
      answer: json['answer'] as String,
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$$Part6AnswerModelImplToJson(
        _$Part6AnswerModelImpl instance) =>
    <String, dynamic>{
      'setId': instance.setId,
      'questionSeq': instance.questionSeq,
      'answer': instance.answer,
      'explanation': instance.explanation,
    };
