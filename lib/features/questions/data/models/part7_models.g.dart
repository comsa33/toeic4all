// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part7_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Part7SetModelImpl _$$Part7SetModelImplFromJson(Map<String, dynamic> json) =>
    _$Part7SetModelImpl(
      id: json['id'] as String,
      difficulty: json['difficulty'] as String,
      questionSetType: json['questionSetType'] as String,
      passages: (json['passages'] as List<dynamic>)
          .map((e) => Part7PassageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Part7QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Part7SetModelImplToJson(_$Part7SetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'difficulty': instance.difficulty,
      'questionSetType': instance.questionSetType,
      'passages': instance.passages,
      'questions': instance.questions,
    };

_$Part7PassageModelImpl _$$Part7PassageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part7PassageModelImpl(
      seq: (json['seq'] as num).toInt(),
      type: json['type'] as String,
      text: json['text'] as String,
      translation: json['translation'] as String,
    );

Map<String, dynamic> _$$Part7PassageModelImplToJson(
        _$Part7PassageModelImpl instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'type': instance.type,
      'text': instance.text,
      'translation': instance.translation,
    };

_$Part7QuestionModelImpl _$$Part7QuestionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part7QuestionModelImpl(
      questionSeq: (json['questionSeq'] as num).toInt(),
      questionType: json['questionType'] as String,
      questionText: json['questionText'] as String,
      questionTranslation: json['questionTranslation'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => Part7ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Part7QuestionModelImplToJson(
        _$Part7QuestionModelImpl instance) =>
    <String, dynamic>{
      'questionSeq': instance.questionSeq,
      'questionType': instance.questionType,
      'questionText': instance.questionText,
      'questionTranslation': instance.questionTranslation,
      'choices': instance.choices,
    };

_$Part7ChoiceModelImpl _$$Part7ChoiceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part7ChoiceModelImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      translation: json['translation'] as String,
    );

Map<String, dynamic> _$$Part7ChoiceModelImplToJson(
        _$Part7ChoiceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'translation': instance.translation,
    };

_$Part7SetsResponseModelImpl _$$Part7SetsResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part7SetsResponseModelImpl(
      success: json['success'] as bool? ?? true,
      count: (json['count'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      sets: (json['sets'] as List<dynamic>)
          .map((e) => Part7SetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Part7SetsResponseModelImplToJson(
        _$Part7SetsResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'total': instance.total,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'sets': instance.sets,
    };

_$Part7AnswerModelImpl _$$Part7AnswerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part7AnswerModelImpl(
      setId: json['setId'] as String,
      questionSeq: (json['questionSeq'] as num).toInt(),
      answer: json['answer'] as String,
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$$Part7AnswerModelImplToJson(
        _$Part7AnswerModelImpl instance) =>
    <String, dynamic>{
      'setId': instance.setId,
      'questionSeq': instance.questionSeq,
      'answer': instance.answer,
      'explanation': instance.explanation,
    };
