import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/number_trivia/presentation/stores/number_trivia_store.dart';

class Injection {
  static final numberTriviaStore = Modular.get<NumberTriviaStore>();
}
