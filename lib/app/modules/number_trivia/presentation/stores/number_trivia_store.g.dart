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
  final _$isEmptyAtom = Atom(name: '_NumberTriviaStoreBase.isEmpty');

  @override
  bool get isEmpty {
    _$isEmptyAtom.reportRead();
    return super.isEmpty;
  }

  @override
  set isEmpty(bool value) {
    _$isEmptyAtom.reportWrite(value, super.isEmpty, () {
      super.isEmpty = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_NumberTriviaStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isLoadedAtom = Atom(name: '_NumberTriviaStoreBase.isLoaded');

  @override
  bool get isLoaded {
    _$isLoadedAtom.reportRead();
    return super.isLoaded;
  }

  @override
  set isLoaded(bool value) {
    _$isLoadedAtom.reportWrite(value, super.isLoaded, () {
      super.isLoaded = value;
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

  @override
  String toString() {
    return '''
isEmpty: ${isEmpty},
isLoading: ${isLoading},
isLoaded: ${isLoaded},
errorMessage: ${errorMessage}
    ''';
  }
}
