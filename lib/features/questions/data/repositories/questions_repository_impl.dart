import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/questions_repository.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/question_response.dart';
import '../datasources/questions_remote_datasource.dart';
import '../models/part5_models.dart';
import '../models/part6_models.dart';
import '../models/part7_models.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsRemoteDataSource remoteDataSource;

  QuestionsRepositoryImpl({required this.remoteDataSource});

  // Part 5
  @override
  Future<Either<Failure, Part5QuestionsResponse>> getPart5Questions({
    String? category,
    String? subtype,
    String? difficulty,
    String? keyword,
    int limit = 10,
    int page = 1,
  }) async {
    try {
      final response = await remoteDataSource.getPart5Questions(
        category: category,
        subtype: subtype,
        difficulty: difficulty,
        keyword: keyword,
        limit: limit,
        page: page,
      );
      
      final entity = Part5QuestionsResponse(
        success: response.success,
        count: response.count,
        total: response.total,
        page: response.page,
        totalPages: response.totalPages,
        questions: response.data.questions.map((q) => q.toEntity()).toList(),
      );
      
      return Right(entity);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 5 questions: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Part5Answer>> getPart5Answer(String questionId) async {
    try {
      final response = await remoteDataSource.getPart5Answer(questionId);
      return Right(response.data.toEntity());
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 5 answer: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart5Categories() async {
    try {
      final response = await remoteDataSource.getPart5Categories();
      return Right(response.data);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 5 categories: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getPart5Subtypes({String? category}) async {
    try {
      final response = await remoteDataSource.getPart5Subtypes(category: category);
      return Right(response.data);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 5 subtypes: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart5Difficulties({
    String? category,
    String? subtype,
  }) async {
    try {
      final response = await remoteDataSource.getPart5Difficulties(
        category: category,
        subtype: subtype,
      );
      return Right(response.data);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 5 difficulties: ${e.toString()}'));
    }
  }

  // Part 6
  @override
  Future<Either<Failure, Part6SetsResponse>> getPart6Sets({
    String? passageType,
    String? difficulty,
    int limit = 2,
    int page = 1,
  }) async {
    try {
      final response = await remoteDataSource.getPart6Sets(
        passageType: passageType,
        difficulty: difficulty,
        limit: limit,
        page: page,
      );
      
      final entity = Part6SetsResponse(
        success: response.success,
        count: response.count,
        total: response.total,
        page: response.page,
        totalPages: response.totalPages,
        sets: response.data.sets.map((s) => s.toEntity()).toList(),
      );
      
      return Right(entity);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 6 sets: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Part6Answer>> getPart6Answer(
    String setId,
    int questionSeq,
  ) async {
    try {
      final response = await remoteDataSource.getPart6Answer(setId, questionSeq);
      return Right(response.data.toEntity());
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 6 answer: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart6PassageTypes() async {
    try {
      final response = await remoteDataSource.getPart6PassageTypes();
      return Right(response.data);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 6 passage types: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart6Difficulties({
    String? passageType,
  }) async {
    try {
      final response = await remoteDataSource.getPart6Difficulties(
        passageType: passageType,
      );
      return Right(response.data);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 6 difficulties: ${e.toString()}'));
    }
  }

  // Part 7
  @override
  Future<Either<Failure, Part7SetsResponse>> getPart7Sets({
    required String setType,
    List<String>? passageTypes,
    String? difficulty,
    int limit = 1,
    int page = 1,
  }) async {
    try {
      final response = await remoteDataSource.getPart7Sets(
        setType: setType,
        passageTypes: passageTypes,
        difficulty: difficulty,
        limit: limit,
        page: page,
      );
      
      final entity = Part7SetsResponse(
        success: response.success,
        count: response.count,
        total: response.total,
        page: response.page,
        totalPages: response.totalPages,
        sets: response.data.sets.map((s) => s.toEntity()).toList(),
      );
      
      return Right(entity);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 7 sets: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Part7Answer>> getPart7Answer(
    String setId,
    int questionSeq,
  ) async {
    try {
      final response = await remoteDataSource.getPart7Answer(setId, questionSeq);
      return Right(response.data.toEntity());
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 7 answer: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPart7SetTypes() async {
    try {
      final response = await remoteDataSource.getPart7SetTypes();
      // SetTypeInfoModel 객체들을 Map<String, dynamic>으로 변환
      final Map<String, dynamic> data = {};
      
      response.data.forEach((key, setTypeInfo) {
        data[key] = {
          'description': setTypeInfo.description,
          'required_passages': setTypeInfo.requiredPassages,
        };
      });
      
      return Right(data);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 7 set types: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart7PassageTypes({
    String? setType,
  }) async {
    try {
      final response = await remoteDataSource.getPart7PassageTypes(
        setType: setType,
      );
      return Right(response.data);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 7 passage types: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<List<String>>>> getPart7PassageCombinations({
    required String setType,
  }) async {
    try {
      final response = await remoteDataSource.getPart7PassageCombinations(
        setType: setType,
      );
      return Right(response.data);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 7 passage combinations: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart7Difficulties({
    String? setType,
  }) async {
    try {
      final response = await remoteDataSource.getPart7Difficulties(
        setType: setType,
      );
      return Right(response.data);
    } catch (e) {
      return Left(Failure.server(message: 'Failed to get Part 7 difficulties: ${e.toString()}'));
    }
  }
}
