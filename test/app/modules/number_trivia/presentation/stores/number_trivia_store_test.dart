import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/app/core/util/input_converter.dart';
import 'package:flutter_tdd/app/modules/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd/app/modules/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_tdd/app/modules/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_tdd/app/modules/number_trivia/presentation/stores/get_trivia_for_concrete_number_store.dart';
import 'package:flutter_tdd/app/modules/number_trivia/presentation/stores/number_trivia_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaStore store;
  GetTriviaForConcreteNumberStore getTriviaForConcreteNumberStore;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockInputConverter = MockInputConverter();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    store = NumberTriviaStore(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
    getTriviaForConcreteNumberStore = GetTriviaForConcreteNumberStore(
      mockGetConcreteNumberTrivia,
      mockInputConverter,
    );
  });

  test('isEmpty observable should be true', () {
    final tIsEmpty = true;
    // assert
    expect(store.isEmpty, equals(tIsEmpty));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia =
        NumberTrivia(number: tNumberParsed, text: 'test trivia');
    test(
        'should call InputConverter to validate and convert the String to an unsigned Int',
        () async {
      // arrange
      when(mockInputConverter.stringToUnsignedInt(any))
          .thenReturn(Right(tNumberParsed));
      // act
      getTriviaForConcreteNumberStore(tNumberString);
      await untilCalled(mockInputConverter.stringToUnsignedInt(
          any)); // await for that call. otherwise, should call verify (method after that, this should return null)
      // assert
      verify(mockInputConverter.stringToUnsignedInt(
          tNumberString)); // verifying if this method was called
    });

    test('should emit [Error] when the input is invalid', () async {
      // arrange
      when(mockInputConverter.stringToUnsignedInt(any))
          .thenReturn(Left(InvalidInputFailure()));
      // act
      final result = getTriviaForConcreteNumberStore(tNumberString);

      // assert
      expect(
          result, equals(Error(errorMessage: INVALID_INPUT_FAILURE_MESSAGE)));
    });
  });
}
