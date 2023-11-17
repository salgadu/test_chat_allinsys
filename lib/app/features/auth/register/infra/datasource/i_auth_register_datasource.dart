import 'package:mensageiro/app/features/auth/login/domain/entity/logged_user.dart';
import 'package:mensageiro/app/features/auth/register/domain/entity/register_auth.dart';

abstract class IAuthRegisterDatasource {
  Future<LoggedUser> registerWithEmailAndPassword(
      {required RegisterAuth regoister});
}
