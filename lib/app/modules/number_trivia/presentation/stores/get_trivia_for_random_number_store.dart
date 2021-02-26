import 'package:mobx/mobx.dart';

import '../../../../core/usecases/usecase.dart';
import 'number_trivia_store.dart';

part 'get_trivia_for_random_number_store.g.dart';

// ignore: must_be_immutable
class GetTriviaForRandomNumberStore = _GetTriviaForRandomNumberStoreBase
    with _$GetTriviaForRandomNumberStore;

// ignore: must_be_immutable
abstract class _GetTriviaForRandomNumberStoreBase extends NumberTriviaStore
    with Store {
  final getRandomNumberTrivia;
  _GetTriviaForRandomNumberStoreBase(this.getRandomNumberTrivia)
      : super(random: getRandomNumberTrivia) {
    this.state = StoreState.initial;
  }
  call() async {
    this.state = StoreState.loading;
    final result = await getRandomNumberTrivia(NoParams());
    this.eitherLoadedOrErrorState(result);
  }
}
