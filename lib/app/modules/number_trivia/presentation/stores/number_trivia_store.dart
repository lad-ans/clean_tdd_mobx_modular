import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/util/input_converter.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_store.g.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero';

@Injectable()
// ignore: must_be_immutable
class NumberTriviaStore = _NumberTriviaStoreBase with _$NumberTriviaStore;

// ignore: must_be_immutable
abstract class _NumberTriviaStoreBase extends Equatable with Store {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  _NumberTriviaStoreBase({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
  })  :
        /**
         * ---------------------------------------
          THAT ASSERTION AVOID PASTE A NULL DEPENDENCY.
          BUT IN OUR CASEIS NOT NECESSARY BECAUSE SOME DEPENDENCY...
          ARE NOT NECESSARY IN ONE OR OTHER STORE
          ----------------------------------------
          assert(concrete != null),
          assert(random != null),
          assert(inputConverter != null),
         * */
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @observable
  bool isEmpty = true;

  @observable
  bool isLoading = false;

  @observable
  bool isLoaded = false;

  @observable
  String errorMessage = '';

  List<Object> get props => [];
}

class Error extends Equatable {
  final String errorMessage;
  Error({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
