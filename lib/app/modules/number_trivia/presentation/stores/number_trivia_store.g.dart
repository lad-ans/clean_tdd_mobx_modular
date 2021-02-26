// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_trivia_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NumberTriviaStore on _NumberTriviaStoreBase, Store {
  Computed<NumberTrivia> _$triviaSwitcherComputed;

  @override
  NumberTrivia get triviaSwitcher => (_$triviaSwitcherComputed ??=
          Computed<NumberTrivia>(() => super.triviaSwitcher,
              name: '_NumberTriviaStoreBase.triviaSwitcher'))
      .value;
  Computed<StoreState> _$stateSwitcherComputed;

  @override
  StoreState get stateSwitcher => (_$stateSwitcherComputed ??=
          Computed<StoreState>(() => super.stateSwitcher,
              name: '_NumberTriviaStoreBase.stateSwitcher'))
      .value;

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

  final _$switcherAtom = Atom(name: '_NumberTriviaStoreBase.switcher');

  @override
  Trivia get switcher {
    _$switcherAtom.reportRead();
    return super.switcher;
  }

  @override
  set switcher(Trivia value) {
    _$switcherAtom.reportWrite(value, super.switcher, () {
      super.switcher = value;
    });
  }

  final _$_NumberTriviaStoreBaseActionController =
      ActionController(name: '_NumberTriviaStoreBase');

  @override
  void triviaAndStateSetter(Trivia triviaSwitcher) {
    final _$actionInfo = _$_NumberTriviaStoreBaseActionController.startAction(
        name: '_NumberTriviaStoreBase.triviaAndStateSetter');
    try {
      return super.triviaAndStateSetter(triviaSwitcher);
    } finally {
      _$_NumberTriviaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
numberTriviaFuture: ${numberTriviaFuture},
numberTrivia: ${numberTrivia},
errorMessage: ${errorMessage},
state: ${state},
switcher: ${switcher},
triviaSwitcher: ${triviaSwitcher},
stateSwitcher: ${stateSwitcher}
    ''';
  }
}
