import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/author.dart';

part 'authors_view_state.freezed.dart';

@freezed
sealed class AuthorsViewState with _$AuthorsViewState {
  const AuthorsViewState._();

  const factory AuthorsViewState.initial() = Initial;

  const factory AuthorsViewState.loading() = Loading;

  const factory AuthorsViewState.loaded(List<Author> authors, String query) =
      Loaded;

  const factory AuthorsViewState.error(String message) = Error;
}
