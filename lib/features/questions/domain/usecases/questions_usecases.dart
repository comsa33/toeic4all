
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/question.dart';
import '../entities/question_response.dart';
import '../repositories/questions_repository.dart';

// Part 5 Use Cases
class GetPart5QuestionsUseCase implements UseCase<Part5QuestionsResponse, GetPart5QuestionsParams> {
  final QuestionsRepository repository;

  GetPart5QuestionsUseCase(this.repository);

  @override
  Future<Either<Failure, Part5QuestionsResponse>> call(GetPart5QuestionsParams params) async {
    return await repository.getPart5Questions(
      page: params.page ?? 1,
      limit: params.limit ?? 10,
      category: params.category,
      subtype: params.subtype,
      difficulty: params.difficulty,
    );
  }
}

class GetPart5QuestionsParams {
  final int? page;
  final int? limit;
  final String? category;
  final String? subtype;
  final String? difficulty;

  GetPart5QuestionsParams({
    this.page,
    this.limit,
    this.category,
    this.subtype,
    this.difficulty,
  });
}

class SubmitPart5AnswerUseCase implements UseCase<Part5Answer, SubmitPart5AnswerParams> {
  final QuestionsRepository repository;

  SubmitPart5AnswerUseCase(this.repository);

  @override
  Future<Either<Failure, Part5Answer>> call(SubmitPart5AnswerParams params) async {
    return await repository.submitPart5Answer(
      questionId: params.questionId,
      selectedAnswer: params.answer,
    );
  }
}

class SubmitPart5AnswerParams {
  final String questionId;
  final String answer;

  SubmitPart5AnswerParams({
    required this.questionId,
    required this.answer,
  });
}

class GetPart5CategoriesUseCase implements NoParamsUseCase<List<String>> {
  final QuestionsRepository repository;

  GetPart5CategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call() async {
    return await repository.getPart5Categories();
  }
}

// Part 6 Use Cases
class GetPart6SetsUseCase implements UseCase<Part6SetsResponse, GetPart6SetsParams> {
  final QuestionsRepository repository;

  GetPart6SetsUseCase(this.repository);

  @override
  Future<Either<Failure, Part6SetsResponse>> call(GetPart6SetsParams params) async {
    return await repository.getPart6Sets(
      page: params.page ?? 1,
      limit: params.limit ?? 2,
      passageType: params.passageType,
      difficulty: params.difficulty,
    );
  }
}

class GetPart6SetsParams {
  final int? page;
  final int? limit;
  final String? passageType;
  final String? difficulty;

  GetPart6SetsParams({
    this.page,
    this.limit,
    this.passageType,
    this.difficulty,
  });
}

class SubmitPart6AnswerUseCase implements UseCase<Part6Answer, SubmitPart6AnswerParams> {
  final QuestionsRepository repository;

  SubmitPart6AnswerUseCase(this.repository);

  @override
  Future<Either<Failure, Part6Answer>> call(SubmitPart6AnswerParams params) async {
    return await repository.submitPart6Answer(
      setId: params.setId,
      questionSeq: params.questionSeq,
      selectedAnswer: params.answer,
    );
  }
}

class SubmitPart6AnswerParams {
  final String setId;
  final int questionSeq;
  final String answer;

  SubmitPart6AnswerParams({
    required this.setId,
    required this.questionSeq,
    required this.answer,
  });
}

// Part 7 Use Cases
class GetPart7SetsUseCase implements UseCase<Part7SetsResponse, GetPart7SetsParams> {
  final QuestionsRepository repository;

  GetPart7SetsUseCase(this.repository);

  @override
  Future<Either<Failure, Part7SetsResponse>> call(GetPart7SetsParams params) async {
    return await repository.getPart7Sets(
      page: params.page ?? 1,
      limit: params.limit ?? 1,
      setType: params.setType ?? '',
      passageTypes: params.passageTypes,
      difficulty: params.difficulty,
    );
  }
}

class GetPart7SetsParams {
  final int? page;
  final int? limit;
  final String? setType;
  final List<String>? passageTypes;
  final String? difficulty;

  GetPart7SetsParams({
    this.page,
    this.limit,
    this.setType,
    this.passageTypes,
    this.difficulty,
  });
}

class SubmitPart7AnswerUseCase implements UseCase<Part7Answer, SubmitPart7AnswerParams> {
  final QuestionsRepository repository;

  SubmitPart7AnswerUseCase(this.repository);

  @override
  Future<Either<Failure, Part7Answer>> call(SubmitPart7AnswerParams params) async {
    return await repository.submitPart7Answer(
      setId: params.setId,
      questionSeq: params.questionSeq,
      selectedAnswer: params.answer,
    );
  }
}

class SubmitPart7AnswerParams {
  final String setId;
  final int questionSeq;
  final String answer;

  SubmitPart7AnswerParams({
    required this.setId,
    required this.questionSeq,
    required this.answer,
  });
}
