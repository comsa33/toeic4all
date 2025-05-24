import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../../data/datasources/questions_remote_datasource.dart';
import '../../data/repositories/questions_repository_impl.dart' show QuestionsRepositoryImpl;
import '../../domain/repositories/questions_repository.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/question_filter.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

// Dio provider with authentication
final questionsApiProvider = Provider<QuestionsRemoteDataSource>((ref) {
  final dio = Dio();
  
  // Add auth interceptor
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final authState = ref.read(authControllerProvider);
      if (authState.accessToken != null) {
        options.headers['Authorization'] = 'Bearer ${authState.accessToken}';
      }
      handler.next(options);
    },
  ));
  
  return QuestionsRemoteDataSource(dio);
});

// Repository provider
final questionsRepositoryProvider = Provider<QuestionsRepository>((ref) {
  final dataSource = ref.read(questionsApiProvider);
  return QuestionsRepositoryImpl(remoteDataSource: dataSource);
});

// Filter state providers
final questionFilterProvider = StateProvider<QuestionFilter>((ref) {
  return const QuestionFilter();
});

// Metadata providers
final part5CategoriesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart5Categories();
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (categories) => categories,
  );
});

final part5SubtypesProvider = FutureProvider.family<List<String>, String?>((ref, category) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart5Subtypes(category: category);
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (subtypes) => subtypes,
  );
});

final part5DifficultiesProvider = FutureProvider.family<List<String>, ({String? category, String? subtype})>((ref, params) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart5Difficulties(category: params.category, subtype: params.subtype);
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (difficulties) => difficulties,
  );
});

final part6PassageTypesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart6PassageTypes();
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (passageTypes) => passageTypes,
  );
});

final part6DifficultiesProvider = FutureProvider.family<List<String>, String?>((ref, passageType) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart6Difficulties(passageType: passageType);
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (difficulties) => difficulties,
  );
});

final part7SetTypesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart7SetTypes();
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (setTypes) => setTypes,
  );
});

final part7PassageTypesProvider = FutureProvider.family<List<String>, String?>((ref, setType) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart7PassageTypes(setType: setType);
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (passageTypes) => passageTypes,
  );
});

final part7DifficultiesProvider = FutureProvider.family<List<String>, String?>((ref, setType) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart7Difficulties(setType: setType);
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (difficulties) => difficulties,
  );
});

// Question providers - Updated to return the actual entity lists instead of response objects
final part5QuestionsProvider = FutureProvider.family<List<Part5Question>, QuestionFilter>((ref, filter) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart5Questions(
    category: filter.category,
    subtype: filter.subtype,
    difficulty: filter.difficulty,
    limit: filter.limit,
    page: filter.page,
  );
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (response) => response.questions, // Extract questions from response
  );
});

final part6SetsProvider = FutureProvider.family<List<Part6Set>, QuestionFilter>((ref, filter) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart6Sets(
    passageType: filter.passageType,
    difficulty: filter.difficulty,
    limit: filter.limit,
    page: filter.page,
  );
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (response) => response.sets, // Extract sets from response
  );
});

final part7SetsProvider = FutureProvider.family<List<Part7Set>, QuestionFilter>((ref, filter) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart7Sets(
    setType: filter.setType!,
    passageTypes: filter.passageTypes,
    difficulty: filter.difficulty,
    limit: filter.limit,
    page: filter.page,
  );
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (response) => response.sets, // Extract sets from response
  );
});

// Answer providers
final part5AnswerProvider = FutureProvider.family<Part5Answer, String>((ref, questionId) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart5Answer(questionId);
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (answer) => answer,
  );
});

final part6AnswerProvider = FutureProvider.family<Part6Answer, ({String setId, int questionSeq})>((ref, params) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart6Answer(params.setId, params.questionSeq);
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (answer) => answer,
  );
});

final part7AnswerProvider = FutureProvider.family<Part7Answer, ({String setId, int questionSeq})>((ref, params) async {
  final repository = ref.read(questionsRepositoryProvider);
  final result = await repository.getPart7Answer(params.setId, params.questionSeq);
  return result.fold(
    (failure) => throw Exception(failure.displayMessage),
    (answer) => answer,
  );
});
