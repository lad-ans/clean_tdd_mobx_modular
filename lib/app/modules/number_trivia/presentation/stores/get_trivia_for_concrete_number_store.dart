import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

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
        );
  call(String numberString) {
    final inputEither = inputConverter.stringToUnsignedInt(numberString);
    return inputEither.fold(
        (l) => Error(errorMessage: INVALID_INPUT_FAILURE_MESSAGE), (r) {});
  }

  @override
  List<Object> get props => [];
}
