import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/auth/login/domain/entity/logged_user.dart';
import 'package:mensageiro/app/features/auth/register/domain/entity/register_auth.dart';
import 'package:mensageiro/app/features/auth/register/domain/repository/register_repository.dart';

abstract class IRegisterUser {
  Future<Either<Failure, LoggedUser>> call(RegisterAuth regoister);
}

class RegisterUser implements IRegisterUser {
  final IRegisterRepository repository;

  RegisterUser(this.repository);
  @override
  Future<Either<Failure, LoggedUser>> call(RegisterAuth register) async {
    if (!register.validate()) {
      return Future.value(
          Left(ParamtersEmptyError(message: "Preencha todos os campos")));
    }
    register.email = '${register.phone}@mensageiro.com';
    return await repository.registerWithEmailAndPassword(register);
  }
}
