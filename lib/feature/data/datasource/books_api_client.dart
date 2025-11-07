import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/api/api_helpers.dart';
import '../../../../core/api/result_adapter.dart';
import '../model/authors_response.dart';

part 'books_api_client.g.dart';

@RestApi(baseUrl: 'https://openlibrary.org/', callAdapter: ResultAdapter)
abstract class BooksApiClient {
  factory BooksApiClient(Dio dio, {String baseUrl}) = _BooksApiClient;

  @GET('/search/authors.json')
  AsyncResult<AuthorsResponse> getAuthorsByQuery(@Query('q') String query);
}
