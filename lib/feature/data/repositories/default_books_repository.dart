import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../core/api/api_helpers.dart';
import '../../domain/model/author.dart';
import '../../domain/repositories/books_repository.dart';
import '../datasource/books_api_client.dart';

@Singleton(as: BooksRepository)
class DefaultBooksRepository implements BooksRepository {
  DefaultBooksRepository(this._booksApiClient);
  final BooksApiClient _booksApiClient;

  @override
  AsyncResult<List<Author>> getAuthorsByQuery(String query) async {
    final response = await _booksApiClient.getAuthorsByQuery(query);
    return response.when(
      (success) => Success(success.docs.map<Author>(Author.fromDto).toList()),
      Error.new,
    );
  }
}
