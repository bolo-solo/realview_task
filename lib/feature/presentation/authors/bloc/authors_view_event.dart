import 'package:freezed_annotation/freezed_annotation.dart';

part 'authors_view_event.freezed.dart';

@freezed
sealed class AuthorsViewEvent with _$AuthorsViewEvent {
  const AuthorsViewEvent._();

  const factory AuthorsViewEvent.init() = Init;

  const factory AuthorsViewEvent.queryChanged(String query) = QueryChanged;

  const factory AuthorsViewEvent.refresh() = Refresh;
}
