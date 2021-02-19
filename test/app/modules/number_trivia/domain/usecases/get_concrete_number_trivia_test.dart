import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/app/modules/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd/app/modules/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_tdd/app/modules/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final testNumber = 1;
  final tNumberTrivia = NumberTrivia(number: testNumber, text: 'test');

  test('should get trivia for the number from repository', () async {
    // arrange:functionality for the mocked instance
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));
    // act
    final result = await usecase(Params(number: testNumber));
    // assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(testNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
