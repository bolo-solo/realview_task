import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:realview_task/feature/domain/model/author.dart';
import 'package:realview_task/feature/domain/repositories/books_repository.dart';
import 'package:realview_task/feature/domain/usecases/get_authors_by_query.dart';

import 'get_authors_by_query_test.mocks.dart';

@GenerateMocks([BooksRepository])
void main() {
  late GetAuthorsByQuery useCase;
  late MockBooksRepository mockBooksRepository;

  setUpAll(() {
    provideDummy<Result<List<Author>, Exception>>(
      Error(Exception('Dummy exception')),
    );
  });

  setUp(() {
    mockBooksRepository = MockBooksRepository();
    useCase = GetAuthorsByQuery(mockBooksRepository);
  });

  group('GetAuthorsByQuery', () {
    const testQuery = 'tolkien';

    test(
      'should return list of authors when repository call is successful',
      () async {
        const authors = [
          Author(
            authorName: 'J.R.R. Tolkien',
            id: 'OL26320A',
            topWork: 'The Lord of the Rings',
            ratingsAverage: 4.5,
            currentlyReading: 1000,
            workCount: 150,
          ),
          Author(
            authorName: 'Christopher Tolkien',
            id: 'OL234567A',
            topWork: 'The Silmarillion',
            ratingsAverage: 4.2,
            currentlyReading: 500,
            workCount: 50,
          ),
        ];

        when(
          mockBooksRepository.getAuthorsByQuery(testQuery),
        ).thenAnswer((_) async => const Success(authors));

        final result = await useCase(testQuery);

        expect(result.isSuccess(), true);
        result.when((resultAuthors) {
          expect(resultAuthors, isA<List<Author>>());
          expect(resultAuthors.length, 2);
          expect(resultAuthors, equals(authors));
        }, (error) => fail('Expected success but got error: $error'));

        verify(mockBooksRepository.getAuthorsByQuery(testQuery)).called(1);
      },
    );

    test('should return error when repository call fails', () async {
      final testException = Exception('Failed to fetch authors');

      when(
        mockBooksRepository.getAuthorsByQuery(testQuery),
      ).thenAnswer((_) async => Error(testException));

      final result = await useCase(testQuery);

      expect(result.isError(), true);
      result.when(
        (authors) => fail('Expected error but got success with: $authors'),
        (error) {
          expect(error, isA<Exception>());
          expect(error.toString(), 'Exception: Failed to fetch authors');
        },
      );

      verify(mockBooksRepository.getAuthorsByQuery(testQuery)).called(1);
    });
  });
}
