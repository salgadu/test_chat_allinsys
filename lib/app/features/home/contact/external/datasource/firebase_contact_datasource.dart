import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/contact/domain/entity/contact.dart';
import 'package:mensageiro/app/features/home/contact/infra/datasource/i_contact_datasource.dart';
import 'package:mensageiro/app/features/home/contact/infra/model/contact_model.dart';

class FirebaseContactDatasource implements IContactDatasource {
  final FirebaseFirestore firestore;
  static const String COLLECTION = 'users';

  FirebaseContactDatasource(this.firestore);

  @override
  Future<List<ContactModel>> getContacts(String uid) async {
    try {
      final contacts = await firestore.collection(COLLECTION).doc(uid).get();
      final result = contacts.data();
      if (result == null) {
        return [];
      }
      final contatcList = (result['contacts'] as List);
      return contatcList.map((e) => ContactModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(message: 'Falha ao buscar contatos');
    }
  }

  @override
  Future<List<Contact>> addContact(String id, Contact contact) async {
    try {
      await firestore.collection(COLLECTION).doc(id).update({
        'contacts': FieldValue.arrayUnion([contact.toMap()])
      });
      return getContacts(id);
    } catch (e) {
      throw ServerException(message: 'Falha ao buscar contatos');
    }
  }

  @override
  Future<bool> deleteContact(String id) async {
    try {
      final contacts = await firestore.collection(COLLECTION).doc(id).get();
      final contatcList = (contacts.data()?['contacts'] as List?) ?? [];
      contatcList.removeWhere((element) => element['id'] == id);
      await firestore
          .collection('user')
          .doc(id)
          .update({'contacts': contatcList});
      return true;
    } catch (e) {
      throw ServerException(message: 'Falha ao deletar contato');
    }
  }

  @override
  Future<bool> updateContact(String id, Contact contact) async {
    try {
      final contacts =
          await firestore.collection(COLLECTION).doc(contact.id).get();
      final contatcList = (contacts.data()?['contacts'] as List?) ?? [];
      contatcList.removeWhere((element) => element['id'] == contact.id);
      contatcList.add(contact);
      await firestore
          .collection('user')
          .doc(contact.id)
          .update({'contacts': contatcList});
      return true;
    } catch (e) {
      throw ServerException(message: 'Falha ao atualizar contato');
    }
  }
}
