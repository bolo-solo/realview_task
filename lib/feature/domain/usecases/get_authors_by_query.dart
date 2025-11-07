import 'package:injectable/injectable.dart';

import '../../../core/api/api_helpers.dart';
import '../../../core/use_case.dart';
import '../model/author.dart';
import '../repositories/books_repository.dart';

@singleton
class GetAuthorsByQuery implements UseCase<AsyncResult<List<Author>>, String> {
  GetAuthorsByQuery(this._booksRepository);
  final BooksRepository _booksRepository;

  @override
  AsyncResult<List<Author>> call(String query) =>
      _booksRepository.getAuthorsByQuery(query);
}
