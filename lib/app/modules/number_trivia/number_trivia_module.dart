import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/number_trivia_local_datasource.dart';
import 'data/datasources/number_trivia_remote_datasource.dart';
import 'data/repositories/number_trivia_repository_impl.dart';
import 'domain/usecases/get_concrete_number_trivia.dart';
import 'domain/usecases/get_random_number_trivia.dart';
import 'presentation/stores/get_trivia_for_concrete_number_store.dart';
import 'presentation/stores/get_trivia_for_random_number_store.dart';
import 'presentation/stores/number_trivia_store.dart';

class NumberTriviaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        //! SharedPreferences
        Bind((i) => SharedPreferences.getInstance()),

        //! datasources
        $NumberTriviaLocalDataSourceImpl,
        $NumberTriviaRemoteDataSourceImpl,

        //! repositories
        $NumberTriviaRepositoryImpl,

        //! usecases
        $GetConcreteNumberTrivia,
        $GetRandomNumberTrivia,

        //! viewmodels
        $NumberTriviaStore,
        $GetTriviaForConcreteNumberStore,
        $GetTriviaForRandomNumberStore
      ];

  @override
  List<ModularRouter> get routers => [];

  static Inject get to => Inject<NumberTriviaModule>.of();
}
