import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../error/failures.dart';

part 'input_converter.g.dart';

@Injectable()
class InputConverter {
  Either<Failure, int> stringToUnsignedInt(String str) {
    try {
      final result = int.parse(str);
      if (result < 0) throw FormatException();
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
