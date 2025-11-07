import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:realview_task/core/consts/name_consts.dart';
import 'package:realview_task/feature/domain/model/author.dart';
import 'package:realview_task/feature/domain/usecases/get_authors_by_query.dart';
import 'package:realview_task/feature/presentation/authors/bloc/authors_view_bloc.dart';
import 'package:realview_task/feature/presentation/authors/bloc/authors_view_event.dart';
import 'package:realview_task/feature/presentation/authors/bloc/authors_view_state.dart';

import 'authors_view_bloc_test.mocks.dart';

@GenerateMocks([GetAuthorsByQuery])
void main() {
  late MockGetAuthorsByQuery mockGetAuthorsByQuery;
  late AuthorsViewBloc bloc;

  setUpAll(() {
    provideDummy<Result<List<Author>, Exception>>(const Success([]));
  });

  setUp(() {
    mockGetAuthorsByQuery = MockGetAuthorsByQuery();
  });

  tearDown(() {
    bloc.close();
  });

  group('AuthorsViewBloc', () {
    final mockAuthors = [
      const Author(
        authorName: 'Test Author 1',
        id: '1',
        topWork: 'Test Work 1',
        ratingsAverage: 4.5,
        currentlyReading: 100,
        workCount: 10,
      ),
      const Author(
        authorName: 'Test Author 2',
        id: '2',
        topWork: 'Test Work 2',
        ratingsAverage: 4,
        currentlyReading: 50,
        workCount: 5,
      ),
    ];

    test('initial state is AuthorsViewState.initial()', () {
      bloc = AuthorsViewBloc(getAuthorsByQuery: mockGetAuthorsByQuery);
      expect(bloc.state, equals(const AuthorsViewState.initial()));
    });

    blocTest<AuthorsViewBloc, AuthorsViewState>(
      'emits [Loading, Loaded] when Init event is added and fetch is successful',
      setUp: () {
        when(
          mockGetAuthorsByQuery.call(NameConsts.initialInputValue),
        ).thenAnswer((_) async => Success(mockAuthors));
      },
      build: () => AuthorsViewBloc(getAuthorsByQuery: mockGetAuthorsByQuery),
      act: (bloc) => bloc.add(const AuthorsViewEvent.init()),
      expect: () => [
        const AuthorsViewState.loading(),
        AuthorsViewState.loaded(mockAuthors, NameConsts.initialInputValue),
      ],
      verify: (_) {
        verify(
          mockGetAuthorsByQuery.call(NameConsts.initialInputValue),
        ).called(1);
      },
    );

    blocTest<AuthorsViewBloc, AuthorsViewState>(
      'emits [Loading, LoadingError] when Init event is added and fetch fails',
      setUp: () {
        when(
          mockGetAuthorsByQuery.call(NameConsts.initialInputValue),
        ).thenAnswer((_) async => Error(Exception('Network error')));
      },
      build: () => AuthorsViewBloc(getAuthorsByQuery: mockGetAuthorsByQuery),
      act: (bloc) => bloc.add(const AuthorsViewEvent.init()),
      expect: () => [
        const AuthorsViewState.loading(),
        const AuthorsViewState.loadingError('Exception: Network error'),
      ],
      verify: (_) {
        verify(
          mockGetAuthorsByQuery.call(NameConsts.initialInputValue),
        ).called(1);
      },
    );

    blocTest<AuthorsViewBloc, AuthorsViewState>(
      'emits [Loading, Loaded] when QueryChanged event is added with new query',
      setUp: () {
        when(
          mockGetAuthorsByQuery.call('Dart'),
        ).thenAnswer((_) async => Success(mockAuthors));
      },
      build: () => AuthorsViewBloc(getAuthorsByQuery: mockGetAuthorsByQuery),
      act: (bloc) => bloc.add(const AuthorsViewEvent.queryChanged('Dart')),
      expect: () => [
        const AuthorsViewState.loading(),
        AuthorsViewState.loaded(mockAuthors, 'Dart'),
      ],
      verify: (_) {
        verify(mockGetAuthorsByQuery.call('Dart')).called(1);
      },
    );

    blocTest<AuthorsViewBloc, AuthorsViewState>(
      'emits [Loading, LoadingError] when QueryChanged event fails',
      setUp: () {
        when(
          mockGetAuthorsByQuery.call('InvalidQuery'),
        ).thenAnswer((_) async => Error(Exception('API error')));
      },
      build: () => AuthorsViewBloc(getAuthorsByQuery: mockGetAuthorsByQuery),
      act: (bloc) =>
          bloc.add(const AuthorsViewEvent.queryChanged('InvalidQuery')),
      expect: () => [
        const AuthorsViewState.loading(),
        const AuthorsViewState.loadingError('Exception: API error'),
      ],
      verify: (_) {
        verify(mockGetAuthorsByQuery.call('InvalidQuery')).called(1);
      },
    );
    blocTest<AuthorsViewBloc, AuthorsViewState>(
      'emits [Loading, Loaded] multiple times when multiple QueryChanged events are added',
      setUp: () {
        when(
          mockGetAuthorsByQuery.call('Dart'),
        ).thenAnswer((_) async => Success(mockAuthors));
        when(
          mockGetAuthorsByQuery.call('Flutter'),
        ).thenAnswer((_) async => Success(mockAuthors));
      },
      build: () => AuthorsViewBloc(getAuthorsByQuery: mockGetAuthorsByQuery),
      act: (bloc) => bloc
        ..add(const AuthorsViewEvent.queryChanged('Dart'))
        ..add(const AuthorsViewEvent.queryChanged('Flutter')),
      expect: () => [
        const AuthorsViewState.loading(),
        AuthorsViewState.loaded(mockAuthors, 'Dart'),
        const AuthorsViewState.loading(),
        AuthorsViewState.loaded(mockAuthors, 'Flutter'),
      ],
      verify: (_) {
        verify(mockGetAuthorsByQuery.call('Dart')).called(1);
        verify(mockGetAuthorsByQuery.call('Flutter')).called(1);
      },
    );

    blocTest<AuthorsViewBloc, AuthorsViewState>(
      'emits [Loading, Loaded] with empty list when API returns empty list',
      setUp: () {
        when(
          mockGetAuthorsByQuery.call('NoResults'),
        ).thenAnswer((_) async => const Success([]));
      },
      build: () => AuthorsViewBloc(getAuthorsByQuery: mockGetAuthorsByQuery),
      act: (bloc) => bloc.add(const AuthorsViewEvent.queryChanged('NoResults')),
      expect: () => [
        const AuthorsViewState.loading(),
        const AuthorsViewState.loaded([], 'NoResults'),
      ],
      verify: (_) {
        verify(mockGetAuthorsByQuery.call('NoResults')).called(1);
      },
    );
  });
}
