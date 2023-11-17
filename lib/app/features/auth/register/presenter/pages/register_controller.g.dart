// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterController on RegisterControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'RegisterControllerBase.isLoading', context: context);

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
      Atom(name: 'RegisterControllerBase.isError', context: context);

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

  late final _$RegisterControllerBaseActionController =
      ActionController(name: 'RegisterControllerBase', context: context);

  @override
  dynamic setLoadind(bool value) {
    final _$actionInfo = _$RegisterControllerBaseActionController.startAction(
        name: 'RegisterControllerBase.setLoadind');
    try {
      return super.setLoadind(value);
    } finally {
      _$RegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$RegisterControllerBaseActionController.startAction(
        name: 'RegisterControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$RegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isError: ${isError}
    ''';
  }
}
