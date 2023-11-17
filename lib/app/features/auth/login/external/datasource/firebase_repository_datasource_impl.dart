import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/auth/login/domain/entity/logged_user.dart';
import 'package:mensageiro/app/features/auth/login/infra/datasource/login_datasource.dart';
import 'package:mensageiro/app/features/auth/login/infra/model/logged_user_model.dart';

class FireBaseRepositoryDataSourceImpl implements ILoginDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FireBaseRepositoryDataSourceImpl(this.auth, this.firestore);

  @override
  Future<LoggedUser?> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user == null) {
        throw ServerException(message: 'Usuário não registrado');
      }

      final phone = credentials.user!.email!.split('@')[0];

      final data = await firestore.collection('users').doc(phone).get();

      if (data.data() != null) {
        return LoggedUserModel.fromMap(data.data()!);
      }

      throw ServerException(
          message:
              'Não foi possível carregar os dados, tente novamente mais tarde');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ServerException(message: 'Telefone ou senha inválido');
      } else if (e.code == 'wrong-password') {
        throw ServerException(message: 'Telefone ou senha inválido');
      }
    } catch (e) {
      throw ServerException(
          message: 'Erro Innterno, por favor tente novamente mais tarde!');
    }
    return null;
  }
}
