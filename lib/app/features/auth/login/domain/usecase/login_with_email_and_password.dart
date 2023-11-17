import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/auth/login/domain/entity/logged_user.dart';
import 'package:mensageiro/app/features/auth/login/domain/repository/login_repository.dart';

abstract class ILoginWithEmailAndPassword {
  Future<Either<Failure, LoggedUser?>> call(
      {required String phone, required String password});
}

class LoginWithEmailAndPassword implements ILoginWithEmailAndPassword {
  final LoginRepository repository;
  LoginWithEmailAndPassword(this.repository);
  @override
  Future<Either<Failure, LoggedUser?>> call(
      {required String phone, required String password}) async {
    if (phone.isEmpty) {
      return Future.value(
          Left(ParamtersEmptyError(message: "insira um email válido")));
    } else if (password.isEmpty) {
      return Future.value(
          Left(ParamtersEmptyError(message: "insira uma senha válida")));
    }
    final email = '$phone@mensageiro.com';
    return await repository.loginWithEmailAndPassword(email, password);
  }
}
