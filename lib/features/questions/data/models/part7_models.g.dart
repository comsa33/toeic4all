// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part7_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

_$Part7SetsDataImpl _$$Part7SetsDataImplFromJson(Map<String, dynamic> json) =>
    _$Part7SetsDataImpl(
      sets: (json['sets'] as List<dynamic>)
          .map((e) => Part7SetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$Part7SetsDataImplToJson(_$Part7SetsDataImpl instance) =>
    <String, dynamic>{
      'sets': instance.sets,
    };

_$Part7AnswerDataImpl _$$Part7AnswerDataImplFromJson(
        Map<String, dynamic> json) =>
    _$Part7AnswerDataImpl(
      setId: json['set_id'] as String,
      questionSeq: (json['question_seq'] as num).toInt(),
      answer: json['answer'] as String,
      explanation: json['explanation'] as String,
    );

Map<String, dynamic> _$$Part7AnswerDataImplToJson(
        _$Part7AnswerDataImpl instance) =>
    <String, dynamic>{
      'set_id': instance.setId,
      'question_seq': instance.questionSeq,
      'answer': instance.answer,
      'explanation': instance.explanation,
    };

_$Part7AnswerResponseModelImpl _$$Part7AnswerResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Part7AnswerResponseModelImpl(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      data: Part7AnswerData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$Part7AnswerResponseModelImplToJson(
        _$Part7AnswerResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_$SetTypeInfoModelImpl _$$SetTypeInfoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SetTypeInfoModelImpl(
      description: json['description'] as String,
      requiredPassages: (json['required_passages'] as num).toInt(),
    );

Map<String, dynamic> _$$SetTypeInfoModelImplToJson(
        _$SetTypeInfoModelImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'required_passages': instance.requiredPassages,
    };

_$Part7PassageCombinationsResponseModelImpl
    _$$Part7PassageCombinationsResponseModelImplFromJson(
            Map<String, dynamic> json) =>
        _$Part7PassageCombinationsResponseModelImpl(
          success: json['success'] as bool? ?? true,
          message: json['message'] as String?,
          data: (json['data'] as List<dynamic>?)
                  ?.map((e) =>
                      (e as List<dynamic>).map((e) => e as String).toList())
                  .toList() ??
              const [],
        );

Map<String, dynamic> _$$Part7PassageCombinationsResponseModelImplToJson(
        _$Part7PassageCombinationsResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
