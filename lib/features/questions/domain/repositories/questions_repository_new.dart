import '../entities/question.dart';

abstract class QuestionsRepository {
  // Part 5
  Future<List<Part5Question>> getPart5Questions({
    String? category,
    String? subtype,
    String? difficulty,
    String? keyword,
    int limit = 10,
    int page = 1,
  });

  Future<Part5Answer> getPart5Answer(String questionId);
  Future<List<String>> getPart5Categories();
  Future<List<String>> getPart5Subtypes({String? category});
  Future<List<String>> getPart5Difficulties({String? category, String? subtype});

  // Part 6
  Future<List<Part6Set>> getPart6Sets({
    String? passageType,
    String? difficulty,
    int limit = 2,
    int page = 1,
  });

  Future<Part6Answer> getPart6Answer(String setId, int questionSeq);
  Future<List<String>> getPart6PassageTypes();
  Future<List<String>> getPart6Difficulties({String? passageType});

  // Part 7
  Future<List<Part7Set>> getPart7Sets({
    required String setType,
    List<String>? passageTypes,
    String? difficulty,
    int limit = 1,
    int page = 1,
  });

  Future<Part7Answer> getPart7Answer(String setId, int questionSeq);
  Future<List<String>> getPart7SetTypes();
  Future<List<String>> getPart7PassageTypes({String? setType});
  Future<List<String>> getPart7Difficulties({String? setType});
}
