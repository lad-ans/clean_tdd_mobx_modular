import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_tdd/app/core/error/failures.dart';
import 'package:flutter_tdd/app/modules/number_trivia/domain/entities/number_trivia.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/util/input_converter.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import 'number_trivia_store.dart';

part 'get_trivia_for_concrete_number_store.g.dart';

@Injectable()
// ignore: must_be_immutable
class GetTriviaForConcreteNumberStore = _GetTriviaForConcreteNumberStoreBase
    with _$GetTriviaForConcreteNumberStore;

// ignore: must_be_immutable
abstract class _GetTriviaForConcreteNumberStoreBase extends NumberTriviaStore
    with Store {
  final getConcreteNumberTrivia;
  final inputConverter;

  _GetTriviaForConcreteNumberStoreBase(
    this.getConcreteNumberTrivia,
    this.inputConverter,
  ) : super(
          concrete: getConcreteNumberTrivia,
          inputConverter: inputConverter,
        ) {
    this.state = StoreState.initial;
  }

  call(String numberString) {
    Either<Failure, NumberTrivia> trivia;
    final inputEither = inputConverter.stringToUnsignedInt(numberString);
    return inputEither.fold(
      (failure) => Error(errorMessage: INVALID_INPUT_FAILURE_MESSAGE),
      (integer) async {
        this.state = StoreState.loading;
        final result = await getConcreteNumberTrivia(
          Params(number: integer),
        );
        return result.fold(
          (failure) {
            Error(errorMessage: mapFailureToMessage(failure));
          },
          (trivia) {
            state = StoreState.loaded;
            this.numberTrivia = trivia;
          },
        );
      },
    );
  }

  @override
  List<Object> get props => [];
}
