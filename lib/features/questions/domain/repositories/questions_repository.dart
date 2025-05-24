
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/question.dart';
import '../entities/question_response.dart';

abstract class QuestionsRepository {
  // Part 5 Questions
  Future<Either<Failure, Part5QuestionsResponse>> getPart5Questions({
    int? page,
    int? size,
    String? category,
    String? subtype,
    String? difficulty,
  });

  Future<Either<Failure, Part5Answer>> submitPart5Answer({
    required String questionId,
    required String answer,
  });

  Future<Either<Failure, List<String>>> getPart5Categories();
  Future<Either<Failure, List<String>>> getPart5Subtypes();
  Future<Either<Failure, List<String>>> getPart5Difficulties();

  // Part 6 Questions
  Future<Either<Failure, Part6SetsResponse>> getPart6Sets({
    int? page,
    int? size,
    String? passageType,
    String? difficulty,
  });

  Future<Either<Failure, Part6Answer>> submitPart6Answer({
    required String setId,
    required int questionSeq,
    required String answer,
  });

  Future<Either<Failure, List<String>>> getPart6PassageTypes();
  Future<Either<Failure, List<String>>> getPart6Difficulties();

  // Part 7 Questions
  Future<Either<Failure, Part7SetsResponse>> getPart7Sets({
    int? page,
    int? size,
    String? setType,
    String? passageType,
    String? passageCombination,
    String? difficulty,
  });

  Future<Either<Failure, Part7Answer>> submitPart7Answer({
    required String setId,
    required int questionSeq,
    required String answer,
  });

  Future<Either<Failure, List<String>>> getPart7SetTypes();
  Future<Either<Failure, List<String>>> getPart7PassageTypes();
  Future<Either<Failure, List<String>>> getPart7PassageCombinations();
  Future<Either<Failure, List<String>>> getPart7Difficulties();

  // System endpoints
  Future<Either<Failure, Map<String, dynamic>>> getSystemHealth();
  Future<Either<Failure, Map<String, dynamic>>> getCacheStats();
}
