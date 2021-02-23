import 'package:flutter_modular/flutter_modular_annotations.dart';
import 'package:mobx/mobx.dart';

import 'number_trivia_store.dart';

part 'get_trivia_for_random_number_store.g.dart';

@Injectable()
// ignore: must_be_immutable
class GetTriviaForRandomNumberStore = _GetTriviaForRandomNumberStoreBase
    with _$GetTriviaForRandomNumberStore;

// ignore: must_be_immutable
abstract class _GetTriviaForRandomNumberStoreBase extends NumberTriviaStore
    with Store {
  call() {
    //TODO
  }
}
