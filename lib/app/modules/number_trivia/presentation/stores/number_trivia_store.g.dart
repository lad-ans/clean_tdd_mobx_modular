// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_trivia_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $NumberTriviaStore = BindInject(
  (i) => NumberTriviaStore(
      concrete: i<GetConcreteNumberTrivia>(),
      random: i<GetRandomNumberTrivia>(),
      inputConverter: i<InputConverter>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NumberTriviaStore on _NumberTriviaStoreBase, Store {
  final _$numberTriviaFutureAtom =
      Atom(name: '_NumberTriviaStoreBase.numberTriviaFuture');

  @override
  ObservableFuture<dynamic> get numberTriviaFuture {
    _$numberTriviaFutureAtom.reportRead();
    return super.numberTriviaFuture;
  }

  @override
  set numberTriviaFuture(ObservableFuture<dynamic> value) {
    _$numberTriviaFutureAtom.reportWrite(value, super.numberTriviaFuture, () {
      super.numberTriviaFuture = value;
    });
  }

  final _$numberTriviaAtom = Atom(name: '_NumberTriviaStoreBase.numberTrivia');

  @override
  NumberTrivia get numberTrivia {
    _$numberTriviaAtom.reportRead();
    return super.numberTrivia;
  }

  @override
  set numberTrivia(NumberTrivia value) {
    _$numberTriviaAtom.reportWrite(value, super.numberTrivia, () {
      super.numberTrivia = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_NumberTriviaStoreBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$stateAtom = Atom(name: '_NumberTriviaStoreBase.state');

  @override
  StoreState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(StoreState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  @override
  String toString() {
    return '''
numberTriviaFuture: ${numberTriviaFuture},
numberTrivia: ${numberTrivia},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}
