import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:realview_task/feature/data/datasource/books_api_client.dart';
import 'package:realview_task/feature/data/model/author_dto.dart';
import 'package:realview_task/feature/data/model/authors_response.dart';
import 'package:realview_task/feature/data/repositories/default_books_repository.dart';
import 'package:realview_task/feature/domain/model/author.dart';

import 'default_books_repository_test.mocks.dart';

@GenerateMocks([BooksApiClient])
void main() {
  late DefaultBooksRepository repository;
  late MockBooksApiClient mockBooksApiClient;

  setUpAll(() {
    provideDummy<Result<AuthorsResponse, Exception>>(
      Error(Exception('Dummy exception')),
    );
  });

  setUp(() {
    mockBooksApiClient = MockBooksApiClient();
    repository = DefaultBooksRepository(mockBooksApiClient);
  });

  group('DefaultBooksRepository', () {
    group('getAuthorsByQuery', () {
      const testQuery = 'tolkien';

      test(
        'should return list of authors when API call is successful',
        () async {
          const docs = [
            AuthorDto(
              authorName: 'J.R.R. Tolkien',
              id: 'OL26320A',
              topWork: 'The Lord of the Rings',
              ratingsAverage: 4.5,
              currentlyReading: 1000,
              workCount: 150,
            ),
            AuthorDto(
              authorName: 'Christopher Tolkien',
              id: 'OL234567A',
              topWork: 'The Silmarillion',
              ratingsAverage: 4.2,
              currentlyReading: 500,
              workCount: 50,
            ),
          ];
          const authorsResponse = AuthorsResponse(
            numFound: 2,
            start: 0,
            numFoundExact: true,
            docs: docs,
          );

          when(
            mockBooksApiClient.getAuthorsByQuery(testQuery),
          ).thenAnswer((_) async => const Success(authorsResponse));

          final result = await repository.getAuthorsByQuery(testQuery);

          expect(result.isSuccess(), true);
          result.when((authors) {
            expect(authors, isA<List<Author>>());
            expect(authors.length, 2);
            expect(authors.first.authorName, docs.first.authorName);
            expect(authors.first.id, docs.first.id);
            expect(authors.first.topWork, docs.first.topWork);
            expect(authors.first.ratingsAverage, docs.first.ratingsAverage);
            expect(authors.first.currentlyReading, docs.first.currentlyReading);
            expect(authors.first.workCount, docs.first.workCount);
            expect(authors.last.authorName, docs.last.authorName);
            expect(authors.last.id, docs.last.id);
          }, (error) => fail('Expected success but got error: $error'));

          verify(mockBooksApiClient.getAuthorsByQuery(testQuery)).called(1);
        },
      );

      test('should return empty list when API returns no authors', () async {
        const authorsResponse = AuthorsResponse(
          numFound: 0,
          start: 0,
          numFoundExact: true,
          docs: [],
        );

        when(
          mockBooksApiClient.getAuthorsByQuery(testQuery),
        ).thenAnswer((_) async => const Success(authorsResponse));

        final result = await repository.getAuthorsByQuery(testQuery);

        expect(result.isSuccess(), true);
        result.when((authors) {
          expect(authors, isA<List<Author>>());
          expect(authors.length, 0);
          expect(authors, isEmpty);
        }, (error) => fail('Expected success but got error: $error'));

        verify(mockBooksApiClient.getAuthorsByQuery(testQuery)).called(1);
      });

      test('should return error when API call fails', () async {
        final testException = Exception('Network error');

        when(
          mockBooksApiClient.getAuthorsByQuery(testQuery),
        ).thenAnswer((_) async => Error(testException));

        final result = await repository.getAuthorsByQuery(testQuery);

        expect(result.isError(), true);
        result.when(
          (authors) => fail('Expected error but got success with: $authors'),
          (error) {
            expect(error, isA<Exception>());
            expect(error.toString(), 'Exception: Network error');
          },
        );

        verify(mockBooksApiClient.getAuthorsByQuery(testQuery)).called(1);
      });
    });
  });
}
