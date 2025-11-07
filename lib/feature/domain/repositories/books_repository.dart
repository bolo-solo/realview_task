import '../../../core/api/api_helpers.dart';
import '../model/author.dart';

abstract interface class BooksRepository {
  AsyncResult<List<Author>> getAuthorsByQuery(String query);
}
