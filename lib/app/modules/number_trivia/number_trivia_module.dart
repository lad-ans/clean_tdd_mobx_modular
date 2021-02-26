import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/number_trivia_page.dart';

class NumberTriviaModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => NumberTriviaPage(),
        )
      ];

  static Inject get to => Inject<NumberTriviaModule>.of();
}
