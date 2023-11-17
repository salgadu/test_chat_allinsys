import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/auth/login/domain/entity/logged_user.dart';
import 'package:mensageiro/app/features/auth/register/domain/entity/register_auth.dart';

abstract class IRegisterRepository {
  Future<Either<Failure, LoggedUser>> registerWithEmailAndPassword(
      RegisterAuth regoister);
}
