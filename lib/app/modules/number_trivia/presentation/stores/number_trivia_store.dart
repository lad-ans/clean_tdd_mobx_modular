import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/util/injection.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_store.g.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero';

// states
enum StoreState { initial, loading, loaded }

// switcher
enum Trivia { concrete, random }

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
          assert(concrete != null),
          assert(random != null),
          assert(inputConverter != null),
        */
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random {
    state = StoreState.initial;
  }

  @observable
  ObservableFuture numberTriviaFuture;

  @observable
  NumberTrivia numberTrivia;

  @observable
  String errorMessage;

  @observable
  StoreState state;

  @observable
  Trivia switcher;

  @action
  void triviaAndStateSetter(Trivia triviaSwitcher) {
    this.switcher = triviaSwitcher;
  }

  @computed
  NumberTrivia get triviaSwitcher {
    switch (switcher) {
      case Trivia.concrete:
        return Injection.getConcreteNumberTriviaStore.numberTrivia;
        break;
      case Trivia.random:
        return Injection.getRandomNumberTriviaStore.numberTrivia;
        break;
      default:
        return NumberTrivia(number: 1, text: 'Error getting trivia');
    }
  }

  @computed
  StoreState get stateSwitcher {
    switch (switcher) {
      case Trivia.concrete:
        return Injection.getConcreteNumberTriviaStore.state;
        break;
      case Trivia.random:
        return Injection.getRandomNumberTriviaStore.state;
        break;
      default:
        return StoreState.initial;
    }
  }

  // @computed
  // StoreState get state {
  //   if (numberTriviaFuture == null ||
  //       numberTriviaFuture.status == FutureStatus.rejected) {
  //     return StoreState.initial;
  //   }
  //   return numberTriviaFuture.status == FutureStatus.pending
  //       ? StoreState.loading
  //       : StoreState.loaded;
  // }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
        break;
      default:
        return 'Unexpected error';
    }
  }

  void eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> result,
  ) {
    return result.fold(
      (failure) => Error(
        errorMessage: mapFailureToMessage(failure),
      ),
      (trivia) {
        state = StoreState.loaded;
        this.numberTrivia = trivia;
      },
    );
  }

  List<Object> get props => [];
}

class Error extends Equatable {
  final String errorMessage;
  Error({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
