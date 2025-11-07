import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_authors_by_query.dart';
import 'authors_view_event.dart';
import 'authors_view_state.dart';

@injectable
class AuthorsViewBloc extends Bloc<AuthorsViewEvent, AuthorsViewState> {
  AuthorsViewBloc({required GetAuthorsByQuery getAuthorsByQuery})
    : _getAuthorsByQuery = getAuthorsByQuery,
      super(const AuthorsViewState.initial()) {
    on<Init>((event, emit) async {
      await _searchAuthors(emit, 'Flutter');
    });
    on<QueryChanged>((event, emit) async {
      await _searchAuthors(emit, event.query);
    });
    on<Refresh>((event, emit) async {
      final query = state.maybeWhen(
        loaded: (authors, query) => query,
        orElse: () => '',
      );

      await _searchAuthors(emit, query);
    });
  }
  final GetAuthorsByQuery _getAuthorsByQuery;

  Future<void> _searchAuthors(
    Emitter<AuthorsViewState> emit,
    String query,
  ) async {
    emit(const AuthorsViewState.loading());
    final withResult = await _getAuthorsByQuery(query);

    if (emit.isDone) {
      return;
    }

    withResult.when(
      (authors) => emit(AuthorsViewState.loaded(authors, query)),
      (error) => emit(AuthorsViewState.error(error.toString())),
    );
  }
}
