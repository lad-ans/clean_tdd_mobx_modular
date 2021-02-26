import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/number_trivia/presentation/stores/get_trivia_for_concrete_number_store.dart';
import '../../modules/number_trivia/presentation/stores/get_trivia_for_random_number_store.dart';
import '../../modules/number_trivia/presentation/stores/number_trivia_store.dart';

class Injection {
  static final numberTriviaStore = Modular.get<NumberTriviaStore>();
  static final getConcreteNumberTriviaStore =
      Modular.get<GetTriviaForConcreteNumberStore>();
  static final getRandomNumberTriviaStore =
      Modular.get<GetTriviaForRandomNumberStore>();
}
