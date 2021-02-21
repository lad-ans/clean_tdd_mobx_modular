import 'dart:convert';

import 'package:flutter_tdd/app/core/error/exceptions.dart';
import 'package:flutter_tdd/app/modules/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:flutter_tdd/app/modules/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getConcreteNumberTrivia', () {
    final testNumber = 1;
    final testNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    void setUpMockHttpClientSuccess200() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
    }

    void setUpMockHttpClientFailure404() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something wrong', 404));
    }

    test('''should perform a GET request on URL with the number
        being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSourceImpl.getConcreteNumberTrivia(testNumber);
      // assert
      verify(mockHttpClient.get(
        'http://numbersapi.com/$testNumber',
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('should return NumberTrivia when the StatusCode is 200', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSourceImpl.getConcreteNumberTrivia(testNumber);
      // assert
      expect(result, equals(testNumberTriviaModel));
    });

    test('should THROW a ServerException when StatusCode is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSourceImpl.getConcreteNumberTrivia;
      // assert
      expect(() => call(testNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final testNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    void setUpMockHttpClientSuccess200() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
    }

    void setUpMockHttpClientFailure404() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something wrong', 404));
    }

    test('''should perform a GET request on URL with the number
        being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSourceImpl.getRandomNumberTrivia();
      // assert
      verify(mockHttpClient.get(
        'http://numbersapi.com/random',
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('should return NumberTrivia when the StatusCode is 200', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSourceImpl.getRandomNumberTrivia();
      // assert
      expect(result, equals(testNumberTriviaModel));
    });

    test('should THROW a ServerException when StatusCode is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSourceImpl.getRandomNumberTrivia;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
