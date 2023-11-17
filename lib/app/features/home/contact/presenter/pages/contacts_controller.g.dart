// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContactsController on ContactsControllerBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'ContactsControllerBase.isLoading', context: context);

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
      Atom(name: 'ContactsControllerBase.isError', context: context);

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

  late final _$listContactsAtom =
      Atom(name: 'ContactsControllerBase.listContacts', context: context);

  @override
  List<Contact>? get listContacts {
    _$listContactsAtom.reportRead();
    return super.listContacts;
  }

  @override
  set listContacts(List<Contact>? value) {
    _$listContactsAtom.reportWrite(value, super.listContacts, () {
      super.listContacts = value;
    });
  }

  late final _$ContactsControllerBaseActionController =
      ActionController(name: 'ContactsControllerBase', context: context);

  @override
  dynamic setLoadind(bool value) {
    final _$actionInfo = _$ContactsControllerBaseActionController.startAction(
        name: 'ContactsControllerBase.setLoadind');
    try {
      return super.setLoadind(value);
    } finally {
      _$ContactsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$ContactsControllerBaseActionController.startAction(
        name: 'ContactsControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$ContactsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setListContacts(List<Contact> value) {
    final _$actionInfo = _$ContactsControllerBaseActionController.startAction(
        name: 'ContactsControllerBase.setListContacts');
    try {
      return super.setListContacts(value);
    } finally {
      _$ContactsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isError: ${isError},
listContacts: ${listContacts}
    ''';
  }
}
