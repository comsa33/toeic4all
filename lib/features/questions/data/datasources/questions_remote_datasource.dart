import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../models/part5_models.dart';
import '../models/part6_models.dart';
import '../models/part7_models.dart';

part 'questions_remote_datasource.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class QuestionsRemoteDataSource {
  factory QuestionsRemoteDataSource(Dio dio, {String baseUrl}) =
      _QuestionsRemoteDataSource;

  // Part 5 endpoints
  @GET(ApiEndpoints.part5Questions)
  Future<Part5QuestionsResponseModel> getPart5Questions({
    @Query('category') String? category,
    @Query('subtype') String? subtype,
    @Query('difficulty') String? difficulty,
    @Query('keyword') String? keyword,
    @Query('limit') int limit = 10,
    @Query('page') int page = 1,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET('/api/v1/questions/part5/{question_id}/answer')
  Future<Part5AnswerModel> getPart5Answer(
    @Path('question_id') String questionId,
  );

  @GET(ApiEndpoints.part5Categories)
  Future<List<String>> getPart5Categories({
    @Query('used_only') bool usedOnly = true,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET(ApiEndpoints.part5Subtypes)
  Future<List<String>> getPart5Subtypes({
    @Query('category') String? category,
    @Query('used_only') bool usedOnly = true,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET(ApiEndpoints.part5Difficulties)
  Future<List<String>> getPart5Difficulties({
    @Query('category') String? category,
    @Query('subtype') String? subtype,
    @Query('used_only') bool usedOnly = true,
    @Query('skip_cache') bool skipCache = false,
  });

  // Part 6 endpoints
  @GET(ApiEndpoints.part6Sets)
  Future<Part6SetsResponseModel> getPart6Sets({
    @Query('passage_type') String? passageType,
    @Query('difficulty') String? difficulty,
    @Query('limit') int limit = 2,
    @Query('page') int page = 1,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET('/api/v1/questions/part6/{set_id}/answers/{question_seq}')
  Future<Part6AnswerModel> getPart6Answer(
    @Path('set_id') String setId,
    @Path('question_seq') int questionSeq,
  );

  @GET(ApiEndpoints.part6PassageTypes)
  Future<List<String>> getPart6PassageTypes({
    @Query('used_only') bool usedOnly = false,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET(ApiEndpoints.part6Difficulties)
  Future<List<String>> getPart6Difficulties({
    @Query('passage_type') String? passageType,
    @Query('used_only') bool usedOnly = false,
    @Query('skip_cache') bool skipCache = false,
  });

  // Part 7 endpoints
  @GET(ApiEndpoints.part7Sets)
  Future<Part7SetsResponseModel> getPart7Sets({
    @Query('set_type') required String setType,
    @Query('passage_types') List<String>? passageTypes,
    @Query('difficulty') String? difficulty,
    @Query('limit') int limit = 1,
    @Query('page') int page = 1,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET('/api/v1/questions/part7/{set_id}/answers/{question_seq}')
  Future<Part7AnswerModel> getPart7Answer(
    @Path('set_id') String setId,
    @Path('question_seq') int questionSeq,
  );

  @GET(ApiEndpoints.part7SetTypes)
  Future<List<String>> getPart7SetTypes({
    @Query('used_only') bool usedOnly = false,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET(ApiEndpoints.part7PassageTypes)
  Future<List<String>> getPart7PassageTypes({
    @Query('set_type') String? setType,
    @Query('used_only') bool usedOnly = false,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET(ApiEndpoints.part7Difficulties)
  Future<List<String>> getPart7Difficulties({
    @Query('set_type') String? setType,
    @Query('used_only') bool usedOnly = false,
    @Query('skip_cache') bool skipCache = false,
  });
}
