import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/core/store/auth/auth_store.dart';
import 'package:mensageiro/app/features/home/contact/domain/entity/contact.dart';
import 'package:mensageiro/app/features/home/contact/domain/usecases/add_contactcs.dart';
import 'package:mensageiro/app/features/home/contact/domain/usecases/get_contacts.dart';
import 'package:mobx/mobx.dart';

part 'contacts_controller.g.dart';

class ContactsController = ContactsControllerBase with _$ContactsController;

abstract class ContactsControllerBase with Store {
  final IGetContacts getContact;
  final IAddContact addContact;
  final AuthStore authStore = Modular.get<AuthStore>();

  ContactsControllerBase(this.getContact, this.addContact) {
    when((_) => listContacts == null,
        () async => await getContacts(id: authStore.user!.phoneNumber));
  }
  @observable
  bool isLoading = false;
  @observable
  bool isError = false;
  @observable
  List<Contact>? listContacts;

  @action
  setLoadind(bool value) => isLoading = value;

  @action
  setError(bool value) => isError = value;

  @action
  setListContacts(List<Contact> value) => listContacts = value;

  Future<void> getContacts({required String id}) async {
    setLoadind(true);
    final result = await getContact(uid: id);
    result.fold((l) {
      print(l.message);
      setError(true);
      setLoadind(false);
    }, (r) {
      setListContacts(r);
      setLoadind(false);
    });
  }

  Future<void> addContactF(String name, String phone) async {
    final contact = Contact(id: phone, name: name, phone: phone, photo: '');
    setLoadind(true);
    final result = await addContact(authStore.user!.phoneNumber, contact);
    result.fold((l) {
      setError(true);
      setLoadind(false);
    }, (r) {
      setListContacts(r);
      setLoadind(false);
    });
  }

  Future<void> deleteContact(Contact contact) async {
    setLoadind(true);
    final result = await getContact(uid: contact.id);
    result.fold((l) {
      setError(true);
      setLoadind(false);
    }, (r) {
      setListContacts(r);
      setLoadind(false);
    });
  }

  Future<void> updateContact(Contact contact) async {
    setLoadind(true);
    final result = await getContact(uid: contact.id);
    result.fold((l) {
      setError(true);
      setLoadind(false);
    }, (r) {
      setListContacts(r);
      setLoadind(false);
    });
  }
}
