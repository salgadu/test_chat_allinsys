// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$authStatusAtom =
      Atom(name: 'AuthStoreBase.authStatus', context: context);

  @override
  AuthStatus? get authStatus {
    _$authStatusAtom.reportRead();
    return super.authStatus;
  }

  @override
  set authStatus(AuthStatus? value) {
    _$authStatusAtom.reportWrite(value, super.authStatus, () {
      super.authStatus = value;
    });
  }

  late final _$userAtom = Atom(name: 'AuthStoreBase.user', context: context);

  @override
  LoggedUser? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(LoggedUser? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$AuthStoreBaseActionController =
      ActionController(name: 'AuthStoreBase', context: context);

  @override
  dynamic setUser(LoggedUser? value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
        name: 'AuthStoreBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAuthStatus(AuthStatus value) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
        name: 'AuthStoreBase.setAuthStatus');
    try {
      return super.setAuthStatus(value);
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
authStatus: ${authStatus},
user: ${user}
    ''';
  }
}
