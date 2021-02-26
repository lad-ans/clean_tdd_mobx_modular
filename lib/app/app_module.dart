import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'app_widget.dart';
import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'modules/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'modules/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'modules/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'modules/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'modules/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'modules/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'modules/number_trivia/number_trivia_module.dart';
import 'modules/number_trivia/presentation/stores/get_trivia_for_concrete_number_store.dart';
import 'modules/number_trivia/presentation/stores/get_trivia_for_random_number_store.dart';
import 'modules/number_trivia/presentation/stores/number_trivia_store.dart';

class AppModule extends MainModule {
  final SharedPreferences prefs;
  AppModule({this.prefs});
  @override
  List<Bind> get binds => [
        //! External
        Bind((i) => http.Client),
        Bind((i) => SharedPreferences.getInstance()),
        Bind((i) => DataConnectionChecker()),

        //! repositories
        Bind((i) => NumberTriviaRepositoryImpl(
            localDataSource: i<NumberTriviaLocalDataSource>(),
            remoteDataSource: i<NumberTriviaRemoteDataSource>(),
            networkInfo: i<NetworkInfo>())),

        //! datasources
        Bind((i) => NumberTriviaLocalDataSourceImpl(
            sharedPreferences: i.get(defaultValue: prefs))),
        Bind((i) => NumberTriviaRemoteDataSourceImpl(
            client: i.get(defaultValue: http.Client()))),
        //! usecases
        Bind((i) => GetConcreteNumberTrivia(i<NumberTriviaRepository>())),
        Bind((i) => GetRandomNumberTrivia(i<NumberTriviaRepository>())),

        //! viewmodels
        Bind((i) => NumberTriviaStore(
            concrete: i<GetConcreteNumberTrivia>(),
            random: i<GetRandomNumberTrivia>(),
            inputConverter: i<InputConverter>())),

        Bind((i) => GetTriviaForConcreteNumberStore(
            i<GetConcreteNumberTrivia>(), i<InputConverter>())),
        Bind((i) => GetTriviaForRandomNumberStore(i<GetRandomNumberTrivia>())),

        //! core
        Bind((i) => InputConverter()),
        Bind(
          (i) => NetworkInfoImpl(connectionChecker: i<DataConnectionChecker>()),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: NumberTriviaModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
