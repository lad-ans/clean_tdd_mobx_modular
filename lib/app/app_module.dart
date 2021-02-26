import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_widget.dart';
import 'modules/number_trivia/number_trivia_module.dart';
import 'modules/number_trivia/presentation/stores/number_trivia_store.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    $NumberTriviaStore,
  ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: NumberTriviaModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
