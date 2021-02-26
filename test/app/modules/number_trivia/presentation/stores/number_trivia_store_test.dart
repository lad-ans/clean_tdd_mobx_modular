import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/app/core/error/failures.dart';
import 'package:flutter_tdd/app/core/usecases/usecase.dart';
import 'package:flutter_tdd/app/core/util/input_converter.dart';
import 'package:flutter_tdd/app/modules/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd/app/modules/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_tdd/app/modules/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_tdd/app/modules/number_trivia/presentation/stores/get_trivia_for_concrete_number_store.dart';
import 'package:flutter_tdd/app/modules/number_trivia/presentation/stores/get_trivia_for_random_number_store.dart';
import 'package:flutter_tdd/app/modules/number_trivia/presentation/stores/number_trivia_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  GetTriviaForConcreteNumberStore getTriviaForConcreteNumberStore;
  GetTriviaForRandomNumberStore getTriviaForRandomNumberStore;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockInputConverter = MockInputConverter();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    getTriviaForConcreteNumberStore = GetTriviaForConcreteNumberStore(
      mockGetConcreteNumberTrivia,
      mockInputConverter,
    );
    getTriviaForRandomNumberStore =
        GetTriviaForRandomNumberStore(mockGetRandomNumberTrivia);
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia =
        NumberTrivia(number: tNumberParsed, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInt(any))
            .thenReturn(Right(tNumberParsed));

    test('should return [state.initial]', () async {
      // assert
      expect(
        getTriviaForConcreteNumberStore.state,
        equals(StoreState.initial),
      );
    });

    test(
        'should call InputConverter to validate and convert the String to an unsigned Int',
        () async {
      // arrange
      setUpMockInputConverterSuccess();
      // act
      await getTriviaForConcreteNumberStore(
          tNumberString); // await for that call. otherwise, should call verify (method after that, this should return null)
      // assert
      verify(mockInputConverter
          .stringToUnsignedInt(any)); // verifying if this method was called
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

    test('should get data from the concrete usecase', () async {
      // arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      // act
      getTriviaForConcreteNumberStore(tNumberString);
      // assert
      verify(mockGetConcreteNumberTrivia(
          Params(number: tNumberParsed))); // if was called
    });

    test('should emit [state.loaded] when data is gotten successfully',
        () async {
      // arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      // act
      await getTriviaForConcreteNumberStore(tNumberString);
      final storeState = getTriviaForConcreteNumberStore.state;
      final expectedState = StoreState.loaded;
      // assert
      expect(storeState, equals(expectedState));
      // verify(getTriviaForConcreteNumberStore(tNumberString));
    });

    test('should emit [state.loading, Error] when getting data fails',
        () async {
      // arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      await getTriviaForConcreteNumberStore(tNumberString);
      final storeStates = [
        getTriviaForConcreteNumberStore.state,
        Error(errorMessage: SERVER_FAILURE_MESSAGE)
      ];
      final expectedStates = [
        StoreState.loading,
        Error(errorMessage: SERVER_FAILURE_MESSAGE)
      ];
      // assert
      expect(storeStates, equals(expectedStates));
    });

    test('''should emit [state.loading, Error]
        with proper message for the error when getting data fails''', () async {
      // arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // act
      await getTriviaForConcreteNumberStore(tNumberString);
      final storeStates = [
        getTriviaForConcreteNumberStore.state,
        Error(errorMessage: CACHE_FAILURE_MESSAGE)
      ];
      final expectedStates = [
        StoreState.loading,
        Error(errorMessage: CACHE_FAILURE_MESSAGE)
      ];
      // assert
      expect(storeStates, equals(expectedStates));
    });
  });

  group('GetTriviaForRandomNumber', () {
    test('should return [state.initial]', () async {
      // assert
      expect(
        getTriviaForRandomNumberStore.state,
        equals(StoreState.initial),
      );
    });

    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');
    test('should get data from the random usecase', () async {
      // arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      // act
      getTriviaForRandomNumberStore();
      await untilCalled(mockGetRandomNumberTrivia(any));
      // assert
      verify(mockGetRandomNumberTrivia(NoParams())); // if was called
    });

    test('should emit [state.loaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      // act
      await getTriviaForRandomNumberStore();
      final storeState = getTriviaForRandomNumberStore.state;
      final expectedState = StoreState.loaded;
      // assert
      expect(storeState, equals(expectedState));
      // verify(getTriviaForRandomNumberStore(tNumberString));
    });

    test('should emit [state.loading, Error] when getting data fails',
        () async {
      // arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      await getTriviaForRandomNumberStore();
      final storeStates = [
        getTriviaForRandomNumberStore.state,
        Error(errorMessage: SERVER_FAILURE_MESSAGE)
      ];
      final expectedStates = [
        StoreState.loading,
        Error(errorMessage: SERVER_FAILURE_MESSAGE)
      ];
      // assert
      expect(storeStates, equals(expectedStates));
    });

    test('''should emit [state.loading, Error]
        with proper message for the error when getting data fails''', () async {
      // arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // act
      await getTriviaForRandomNumberStore();
      final storeStates = [
        getTriviaForRandomNumberStore.state,
        Error(errorMessage: CACHE_FAILURE_MESSAGE)
      ];
      final expectedStates = [
        StoreState.loading,
        Error(errorMessage: CACHE_FAILURE_MESSAGE)
      ];
      // assert
      expect(storeStates, equals(expectedStates));
    });
  });
}
