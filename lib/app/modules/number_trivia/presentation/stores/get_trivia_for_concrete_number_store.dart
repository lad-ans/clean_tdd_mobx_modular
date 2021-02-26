import 'package:flutter_modular/flutter_modular.dart';
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
    final inputEither = inputConverter.stringToUnsignedInt(numberString);
    return inputEither.fold(
      (failure) => Error(errorMessage: INVALID_INPUT_FAILURE_MESSAGE),
      (integer) async {
        this.state = StoreState.loading;
        final result = await getConcreteNumberTrivia(
          Params(number: integer),
        );
        if (result != null) this.eitherLoadedOrErrorState(result);
        return null;
      },
    );
  }

  @override
  List<Object> get props => [];
}
