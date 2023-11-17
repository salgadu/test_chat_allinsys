// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on LoginControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'LoginControllerBase.isLoading', context: context);

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

  late final _$isErrorAtom =
      Atom(name: 'LoginControllerBase.isError', context: context);

  @override
  bool get isError {
    _$isErrorAtom.reportRead();
    return super.isError;
  }

  @override
  set isError(bool value) {
    _$isErrorAtom.reportWrite(value, super.isError, () {
      super.isError = value;
    });
  }

  late final _$messageErrorAtom =
      Atom(name: 'LoginControllerBase.messageError', context: context);

  @override
  String get messageError {
    _$messageErrorAtom.reportRead();
    return super.messageError;
  }

  @override
  set messageError(String value) {
    _$messageErrorAtom.reportWrite(value, super.messageError, () {
      super.messageError = value;
    });
  }

  late final _$LoginControllerBaseActionController =
      ActionController(name: 'LoginControllerBase', context: context);

  @override
  dynamic setLoadind(bool value) {
    final _$actionInfo = _$LoginControllerBaseActionController.startAction(
        name: 'LoginControllerBase.setLoadind');
    try {
      return super.setLoadind(value);
    } finally {
      _$LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$LoginControllerBaseActionController.startAction(
        name: 'LoginControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMessageError(String value) {
    final _$actionInfo = _$LoginControllerBaseActionController.startAction(
        name: 'LoginControllerBase.setMessageError');
    try {
      return super.setMessageError(value);
    } finally {
      _$LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isError: ${isError},
messageError: ${messageError}
    ''';
  }
}
