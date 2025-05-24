
import 'question.dart';

// Part 5 Questions Response
class Part5QuestionsResponse {
  final bool success;
  final int count;
  final int total;
  final int page;
  final int totalPages;
  final List<Part5Question> questions;

  const Part5QuestionsResponse({
    this.success = true,
    required this.count,
    required this.total,
    required this.page,
    required this.totalPages,
    required this.questions,
  });

  Part5QuestionsResponse copyWith({
    bool? success,
    int? count,
    int? total,
    int? page,
    int? totalPages,
    List<Part5Question>? questions,
  }) {
    return Part5QuestionsResponse(
      success: success ?? this.success,
      count: count ?? this.count,
      total: total ?? this.total,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      questions: questions ?? this.questions,
    );
  }
}

// Part 6 Sets Response
class Part6SetsResponse {
  final bool success;
  final int count;
  final int total;
  final int page;
  final int totalPages;
  final List<Part6Set> sets;

  const Part6SetsResponse({
    this.success = true,
    required this.count,
    required this.total,
    required this.page,
    required this.totalPages,
    required this.sets,
  });

  Part6SetsResponse copyWith({
    bool? success,
    int? count,
    int? total,
    int? page,
    int? totalPages,
    List<Part6Set>? sets,
  }) {
    return Part6SetsResponse(
      success: success ?? this.success,
      count: count ?? this.count,
      total: total ?? this.total,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      sets: sets ?? this.sets,
    );
  }
}

// Part 7 Sets Response
class Part7SetsResponse {
  final bool success;
  final int count;
  final int total;
  final int page;
  final int totalPages;
  final List<Part7Set> sets;

  const Part7SetsResponse({
    this.success = true,
    required this.count,
    required this.total,
    required this.page,
    required this.totalPages,
    required this.sets,
  });

  Part7SetsResponse copyWith({
    bool? success,
    int? count,
    int? total,
    int? page,
    int? totalPages,
    List<Part7Set>? sets,
  }) {
    return Part7SetsResponse(
      success: success ?? this.success,
      count: count ?? this.count,
      total: total ?? this.total,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      sets: sets ?? this.sets,
    );
  }
}
