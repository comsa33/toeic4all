import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
    bool skipCache = true,
  }) async {
    try {
      print('🔄 Part5 Questions 요청 시작');
      print(
        '📤 파라미터: category=$category, subtype=$subtype, difficulty=$difficulty, limit=$limit, page=$page, skipCache=$skipCache',
      );

      final response = await remoteDataSource.getPart5Questions(
        category: category,
        subtype: subtype,
        difficulty: difficulty,
        keyword: keyword,
        limit: limit,
        page: page,
        skipCache: skipCache,
      );

      print('✅ Part5 Questions API 응답 성공');
      print(
        '📥 응답 데이터: success=${response.success}, count=${response.count}, total=${response.total}',
      );

      final entity = Part5QuestionsResponse(
        success: response.success,
        count: response.count,
        total: response.total,
        page: response.page,
        totalPages: response.totalPages,
        questions: response.data.questions.map((q) => q.toEntity()).toList(),
      );

      print('✅ Part5 Questions Entity 변환 성공: ${entity.questions.length}개 문제');
      return Right(entity);
    } catch (e, stackTrace) {
      print('❌ Part5 Questions 에러 발생');
      print('🔍 에러 타입: ${e.runtimeType}');
      print('📝 에러 내용: $e');
      print('📍 스택 트레이스: $stackTrace');

      String errorMessage = 'Failed to get Part 5 questions';

      if (e is DioException) {
        print('🌐 DioException 상세 정보:');
        print('   - 응답 코드: ${e.response?.statusCode}');
        print('   - 응답 데이터: ${e.response?.data}');
        print('   - 요청 URL: ${e.requestOptions.uri}');

        errorMessage = 'Network error: ${e.message}';
        if (e.response?.statusCode != null) {
          errorMessage += ' (Status: ${e.response!.statusCode})';
        }
      } else if (e is FormatException || e.toString().contains('type cast')) {
        errorMessage = 'Data parsing error: ${e.toString()}';
      }

      return Left(Failure.server(message: '$errorMessage: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Part5Answer>> getPart5Answer(String questionId) async {
    try {
      final response = await remoteDataSource.getPart5Answer(questionId);
      return Right(response.data.toEntity());
    } catch (e) {
      print('❌ Part5 Answer 에러: $e');
      return Left(
        Failure.server(message: 'Failed to get Part 5 answer: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart5Categories({
    bool skipCache = true,
  }) async {
    try {
      final response = await remoteDataSource.getPart5Categories(
        skipCache: skipCache,
      );
      return Right(response.data);
    } catch (e) {
      print('❌ Part5 Categories 에러: $e');
      return Left(
        Failure.server(
          message: 'Failed to get Part 5 categories: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, dynamic>> getPart5Subtypes({
    String? category,
    bool skipCache = true,
  }) async {
    try {
      final response = await remoteDataSource.getPart5Subtypes(
        category: category,
        skipCache: skipCache,
      );
      return Right(response.data);
    } catch (e) {
      print('❌ Part5 Subtypes 에러: $e');
      return Left(
        Failure.server(
          message: 'Failed to get Part 5 subtypes: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart5Difficulties({
    String? category,
    String? subtype,
    bool skipCache = true,
  }) async {
    try {
      final response = await remoteDataSource.getPart5Difficulties(
        category: category,
        subtype: subtype,
        skipCache: skipCache,
      );
      return Right(response.data);
    } catch (e) {
      print('❌ Part5 Difficulties 에러: $e');
      return Left(
        Failure.server(
          message: 'Failed to get Part 5 difficulties: ${e.toString()}',
        ),
      );
    }
  }

  // Part 6
  @override
  Future<Either<Failure, Part6SetsResponse>> getPart6Sets({
    String? passageType,
    String? difficulty,
    int limit = 2,
    int page = 1,
    bool skipCache = true,
  }) async {
    try {
      print('🔄 Part6 Sets 요청 시작');
      print(
        '📤 파라미터: passageType=$passageType, difficulty=$difficulty, limit=$limit, page=$page, skipCache=$skipCache',
      );

      final response = await remoteDataSource.getPart6Sets(
        passageType: passageType,
        difficulty: difficulty,
        limit: limit,
        page: page,
        skipCache: skipCache,
      );

      print('✅ Part6 Sets API 응답 성공');

      final entity = Part6SetsResponse(
        success: response.success,
        count: response.count,
        total: response.total,
        page: response.page,
        totalPages: response.totalPages,
        sets: response.data.sets.map((s) => s.toEntity()).toList(),
      );

      print('✅ Part6 Sets Entity 변환 성공: ${entity.sets.length}개 세트');
      return Right(entity);
    } catch (e) {
      print('❌ Part6 Sets 에러 발생');
      print('🔍 에러 타입: ${e.runtimeType}');
      print('📝 에러 내용: $e');

      String errorMessage = 'Failed to get Part 6 sets';
      if (e is DioException) {
        errorMessage = 'Network error: ${e.message}';
        if (e.response?.statusCode != null) {
          errorMessage += ' (Status: ${e.response!.statusCode})';
        }
      }

      return Left(Failure.server(message: '$errorMessage: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Part6Answer>> getPart6Answer(
    String setId,
    int questionSeq,
  ) async {
    try {
      final response = await remoteDataSource.getPart6Answer(
        setId,
        questionSeq,
      );
      return Right(response.data.toEntity());
    } catch (e) {
      return Left(
        Failure.server(message: 'Failed to get Part 6 answer: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart6PassageTypes({
    bool skipCache = true,
  }) async {
    try {
      final response = await remoteDataSource.getPart6PassageTypes(
        skipCache: skipCache,
      );
      return Right(response.data);
    } catch (e) {
      return Left(
        Failure.server(
          message: 'Failed to get Part 6 passage types: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart6Difficulties({
    String? passageType,
    bool skipCache = true,
  }) async {
    try {
      final response = await remoteDataSource.getPart6Difficulties(
        passageType: passageType,
        skipCache: skipCache,
      );
      return Right(response.data);
    } catch (e) {
      return Left(
        Failure.server(
          message: 'Failed to get Part 6 difficulties: ${e.toString()}',
        ),
      );
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
    bool skipCache = true,
  }) async {
    try {
      print('🔄 Part7 Sets 요청 시작');
      print(
        '📤 파라미터: setType=$setType, passageTypes=$passageTypes, difficulty=$difficulty, limit=$limit, page=$page, skipCache=$skipCache',
      );

      final response = await remoteDataSource.getPart7Sets(
        setType: setType,
        passageTypes: passageTypes,
        difficulty: difficulty,
        limit: limit,
        page: page,
        skipCache: skipCache,
      );

      print('✅ Part7 Sets API 응답 성공');

      final entity = Part7SetsResponse(
        success: response.success,
        count: response.count,
        total: response.total,
        page: response.page,
        totalPages: response.totalPages,
        sets: response.data.sets.map((s) => s.toEntity()).toList(),
      );

      print('✅ Part7 Sets Entity 변환 성공: ${entity.sets.length}개 세트');
      return Right(entity);
    } catch (e) {
      print('❌ Part7 Sets 에러 발생');
      print('🔍 에러 타입: ${e.runtimeType}');
      print('📝 에러 내용: $e');

      String errorMessage = 'Failed to get Part 7 sets';
      if (e is DioException) {
        errorMessage = 'Network error: ${e.message}';
        if (e.response?.statusCode != null) {
          errorMessage += ' (Status: ${e.response!.statusCode})';
        }
      }

      return Left(Failure.server(message: '$errorMessage: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Part7Answer>> getPart7Answer(
    String setId,
    int questionSeq,
  ) async {
    try {
      final response = await remoteDataSource.getPart7Answer(
        setId,
        questionSeq,
      );
      return Right(response.data.toEntity());
    } catch (e) {
      return Left(
        Failure.server(message: 'Failed to get Part 7 answer: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPart7SetTypes({
    bool skipCache = true,
  }) async {
    try {
      final response = await remoteDataSource.getPart7SetTypes(
        skipCache: skipCache,
      );
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
      return Left(
        Failure.server(
          message: 'Failed to get Part 7 set types: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart7PassageTypes({
    String? setType,
    bool skipCache = true,
  }) async {
    try {
      final response = await remoteDataSource.getPart7PassageTypes(
        setType: setType,
        skipCache: skipCache,
      );
      return Right(response.data);
    } catch (e) {
      return Left(
        Failure.server(
          message: 'Failed to get Part 7 passage types: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<List<String>>>> getPart7PassageCombinations({
    required String setType,
    bool skipCache = true,
  }) async {
    try {
      final response = await remoteDataSource.getPart7PassageCombinations(
        setType: setType,
        skipCache: skipCache,
      );
      return Right(response.data);
    } catch (e) {
      return Left(
        Failure.server(
          message: 'Failed to get Part 7 passage combinations: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPart7Difficulties({
    String? setType,
    bool skipCache = true,
  }) async {
    try {
      final response = await remoteDataSource.getPart7Difficulties(
        setType: setType,
        skipCache: skipCache,
      );
      return Right(response.data);
    } catch (e) {
      return Left(
        Failure.server(
          message: 'Failed to get Part 7 difficulties: ${e.toString()}',
        ),
      );
    }
  }
}
