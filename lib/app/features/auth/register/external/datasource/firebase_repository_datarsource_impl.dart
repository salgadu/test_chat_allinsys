import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/auth/login/domain/entity/logged_user.dart';
import 'package:mensageiro/app/features/auth/register/domain/entity/register_auth.dart';
import 'package:mensageiro/app/features/auth/register/infra/datasource/i_auth_register_datasource.dart';

class FireBaseRepositoryDataSource implements IAuthRegisterDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FireBaseRepositoryDataSource(this.auth, this.firestore);

  @override
  Future<LoggedUser> registerWithEmailAndPassword(
      {required RegisterAuth regoister}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: regoister.email, password: regoister.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ServerException(message: 'A senha fornecida é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw ServerException(message: 'Telefone já cadastrado!');
      }
    } catch (e) {
      throw ServerException(
          message: 'Erro interno, tente novamente mais tarde');
    }

    final user = {
      "name": regoister.name,
      "email": regoister.email,
      "phone": regoister.phone,
      "contacts": [],
    };
    await firestore
        .collection('users')
        .doc(regoister.phone)
        .set(user)
        .onError((error, stackTrace) => print(error));
    return LoggedUser(
      email: regoister.email,
      name: regoister.name,
      phoneNumber: regoister.phone,
    );
  }
}
