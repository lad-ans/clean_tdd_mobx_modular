import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/app/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
        'should return an Integer when the string represents an unsigned integer',
        () async {
      // arrange
      final str = '123';
      // act
      final result = inputConverter.stringToUnsignedInt(str);
      // assert
      expect(result, Right(123));
    });

    test('should return a Failure when the String is not a Integer', () async {
      // arrange
      final str = 'abc';
      // act
      final result = inputConverter.stringToUnsignedInt(str);
      // assert
      expect(result, Left(InvalidInputFailure()));
    });

    test('should return a Failure when the String is a negative Integer', () async {
      // arrange
      final str = '-123';
      // act
      final result = inputConverter.stringToUnsignedInt(str);
      // assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
