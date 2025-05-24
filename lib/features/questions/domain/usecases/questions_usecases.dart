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
      keyword: params.keyword,
    );
  }
}

class GetPart5QuestionsParams {
  final int? page;
  final int? limit;
  final String? category;
  final String? subtype;
  final String? difficulty;
  final String? keyword;

  GetPart5QuestionsParams({
    this.page,
    this.limit,
    this.category,
    this.subtype,
    this.difficulty,
    this.keyword,
  });
}

class GetPart5AnswerUseCase implements UseCase<Part5Answer, GetPart5AnswerParams> {
  final QuestionsRepository repository;

  GetPart5AnswerUseCase(this.repository);

  @override
  Future<Either<Failure, Part5Answer>> call(GetPart5AnswerParams params) async {
    return await repository.getPart5Answer(params.questionId);
  }
}

class GetPart5AnswerParams {
  final String questionId;

  GetPart5AnswerParams({required this.questionId});
}

class GetPart5CategoriesUseCase implements NoParamsUseCase<List<String>> {
  final QuestionsRepository repository;

  GetPart5CategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call() async {
    return await repository.getPart5Categories();
  }
}

class GetPart5SubtypesUseCase implements UseCase<dynamic, GetPart5SubtypesParams> {
  final QuestionsRepository repository;

  GetPart5SubtypesUseCase(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(GetPart5SubtypesParams params) async {
    return await repository.getPart5Subtypes(category: params.category);
  }
}

class GetPart5SubtypesParams {
  final String? category;

  GetPart5SubtypesParams({this.category});
}

class GetPart5DifficultiesUseCase implements UseCase<List<String>, GetPart5DifficultiesParams> {
  final QuestionsRepository repository;

  GetPart5DifficultiesUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(GetPart5DifficultiesParams params) async {
    return await repository.getPart5Difficulties(
      category: params.category,
      subtype: params.subtype,
    );
  }
}

class GetPart5DifficultiesParams {
  final String? category;
  final String? subtype;

  GetPart5DifficultiesParams({this.category, this.subtype});
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

class GetPart6AnswerUseCase implements UseCase<Part6Answer, GetPart6AnswerParams> {
  final QuestionsRepository repository;

  GetPart6AnswerUseCase(this.repository);

  @override
  Future<Either<Failure, Part6Answer>> call(GetPart6AnswerParams params) async {
    return await repository.getPart6Answer(
      params.setId,
      params.questionSeq,
    );
  }
}

class GetPart6AnswerParams {
  final String setId;
  final int questionSeq;

  GetPart6AnswerParams({
    required this.setId,
    required this.questionSeq,
  });
}

class GetPart6PassageTypesUseCase implements NoParamsUseCase<List<String>> {
  final QuestionsRepository repository;

  GetPart6PassageTypesUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call() async {
    return await repository.getPart6PassageTypes();
  }
}

class GetPart6DifficultiesUseCase implements UseCase<List<String>, GetPart6DifficultiesParams> {
  final QuestionsRepository repository;

  GetPart6DifficultiesUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(GetPart6DifficultiesParams params) async {
    return await repository.getPart6Difficulties(passageType: params.passageType);
  }
}

class GetPart6DifficultiesParams {
  final String? passageType;

  GetPart6DifficultiesParams({this.passageType});
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
      setType: params.setType ?? 'Single',
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

class GetPart7AnswerUseCase implements UseCase<Part7Answer, GetPart7AnswerParams> {
  final QuestionsRepository repository;

  GetPart7AnswerUseCase(this.repository);

  @override
  Future<Either<Failure, Part7Answer>> call(GetPart7AnswerParams params) async {
    return await repository.getPart7Answer(
      params.setId,
      params.questionSeq,
    );
  }
}

class GetPart7AnswerParams {
  final String setId;
  final int questionSeq;

  GetPart7AnswerParams({
    required this.setId,
    required this.questionSeq,
  });
}

class GetPart7SetTypesUseCase implements NoParamsUseCase<Map<String, dynamic>> {
  final QuestionsRepository repository;

  GetPart7SetTypesUseCase(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call() async {
    return await repository.getPart7SetTypes();
  }
}

class GetPart7PassageTypesUseCase implements UseCase<List<String>, GetPart7PassageTypesParams> {
  final QuestionsRepository repository;

  GetPart7PassageTypesUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(GetPart7PassageTypesParams params) async {
    return await repository.getPart7PassageTypes(setType: params.setType);
  }
}

class GetPart7PassageTypesParams {
  final String? setType;

  GetPart7PassageTypesParams({this.setType});
}

class GetPart7PassageCombinationsUseCase implements UseCase<List<List<String>>, GetPart7PassageCombinationsParams> {
  final QuestionsRepository repository;

  GetPart7PassageCombinationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<List<String>>>> call(GetPart7PassageCombinationsParams params) async {
    return await repository.getPart7PassageCombinations(setType: params.setType);
  }
}

class GetPart7PassageCombinationsParams {
  final String setType;

  GetPart7PassageCombinationsParams({required this.setType});
}

class GetPart7DifficultiesUseCase implements UseCase<List<String>, GetPart7DifficultiesParams> {
  final QuestionsRepository repository;

  GetPart7DifficultiesUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(GetPart7DifficultiesParams params) async {
    return await repository.getPart7Difficulties(setType: params.setType);
  }
}

class GetPart7DifficultiesParams {
  final String? setType;

  GetPart7DifficultiesParams({this.setType});
}
