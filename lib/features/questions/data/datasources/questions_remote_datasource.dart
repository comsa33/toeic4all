import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../models/common_models.dart';
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
  Future<Part5AnswerResponseModel> getPart5Answer(
    @Path('question_id') String questionId,
  );

  @GET(ApiEndpoints.part5Categories)
  Future<ApiMetadataResponse> getPart5Categories({
    @Query('used_only') bool usedOnly = true,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET(ApiEndpoints.part5Subtypes)
  Future<ApiSubtypesResponse> getPart5Subtypes({
    @Query('category') String? category,
    @Query('used_only') bool usedOnly = true,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET(ApiEndpoints.part5Difficulties)
  Future<ApiMetadataResponse> getPart5Difficulties({
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
  Future<Part6AnswerResponseModel> getPart6Answer(
    @Path('set_id') String setId,
    @Path('question_seq') int questionSeq,
  );

  @GET(ApiEndpoints.part6PassageTypes)
  Future<ApiMetadataResponse> getPart6PassageTypes({
    @Query('used_only') bool usedOnly = false,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET(ApiEndpoints.part6Difficulties)
  Future<ApiMetadataResponse> getPart6Difficulties({
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
  Future<Part7AnswerResponseModel> getPart7Answer(
    @Path('set_id') String setId,
    @Path('question_seq') int questionSeq,
  );

  @GET(ApiEndpoints.part7SetTypes)
  Future<Part7SetTypesResponseModel> getPart7SetTypes({
    @Query('used_only') bool usedOnly = false,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET(ApiEndpoints.part7PassageTypes)
  Future<ApiMetadataResponse> getPart7PassageTypes({
    @Query('set_type') String? setType,
    @Query('used_only') bool usedOnly = false,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET(ApiEndpoints.part7PassageCombinations)
  Future<Part7PassageCombinationsResponseModel> getPart7PassageCombinations({
    @Query('set_type') required String setType,
    @Query('skip_cache') bool skipCache = false,
  });

  @GET(ApiEndpoints.part7Difficulties)
  Future<ApiMetadataResponse> getPart7Difficulties({
    @Query('set_type') String? setType,
    @Query('used_only') bool usedOnly = false,
    @Query('skip_cache') bool skipCache = false,
  });
}
