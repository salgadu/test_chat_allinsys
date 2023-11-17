import 'package:mensageiro/app/features/auth/login/domain/entity/logged_user.dart';

abstract class ILoginDatasource {
  Future<LoggedUser?> loginWithEmailAndPassword(
      {required String email, required String password});
}
