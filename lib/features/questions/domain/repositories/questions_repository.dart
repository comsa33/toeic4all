import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/question.dart';
import '../entities/question_response.dart';

abstract class QuestionsRepository {
  // Part 5 Methods
  Future<Either<Failure, Part5QuestionsResponse>> getPart5Questions({
    String? category,
    String? subtype,
    String? difficulty,
    String? keyword,
    int limit = 10,
    int page = 1,
  });

  Future<Either<Failure, Part5Answer>> getPart5Answer(String questionId);
  
  Future<Either<Failure, Part5Answer>> submitPart5Answer({
    required String questionId,
    required String selectedAnswer,
  });
  
  Future<Either<Failure, List<String>>> getPart5Categories();
  
  Future<Either<Failure, List<String>>> getPart5Subtypes({String? category});
  
  Future<Either<Failure, List<String>>> getPart5Difficulties({String? category, String? subtype});

  // Part 6 Methods
  Future<Either<Failure, Part6SetsResponse>> getPart6Sets({
    String? passageType,
    String? difficulty,
    int limit = 2,
    int page = 1,
  });

  Future<Either<Failure, Part6Answer>> getPart6Answer(String setId, int questionSeq);
  
  Future<Either<Failure, Part6Answer>> submitPart6Answer({
    required String setId,
    required int questionSeq,
    required String selectedAnswer,
  });
  
  Future<Either<Failure, List<String>>> getPart6PassageTypes();
  
  Future<Either<Failure, List<String>>> getPart6Difficulties({String? passageType});

  // Part 7 Methods
  Future<Either<Failure, Part7SetsResponse>> getPart7Sets({
    required String setType,
    List<String>? passageTypes,
    String? difficulty,
    int limit = 1,
    int page = 1,
  });

  Future<Either<Failure, Part7Answer>> getPart7Answer(String setId, int questionSeq);
  
  Future<Either<Failure, Part7Answer>> submitPart7Answer({
    required String setId,
    required int questionSeq,
    required String selectedAnswer,
  });
  
  Future<Either<Failure, List<String>>> getPart7SetTypes();
  
  Future<Either<Failure, List<String>>> getPart7PassageTypes({String? setType});
  
  Future<Either<Failure, List<String>>> getPart7Difficulties({String? setType});
}