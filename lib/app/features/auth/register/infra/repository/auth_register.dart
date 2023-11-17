import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/auth/login/domain/entity/logged_user.dart';
import 'package:mensageiro/app/features/auth/register/domain/entity/register_auth.dart';
import 'package:mensageiro/app/features/auth/register/domain/repository/register_repository.dart';
import 'package:mensageiro/app/features/auth/register/infra/datasource/i_auth_register_datasource.dart';

class AuthRegisterRepository implements IRegisterRepository {
  final IAuthRegisterDatasource datasource;

  AuthRegisterRepository(this.datasource);
  @override
  Future<Either<Failure, LoggedUser>> registerWithEmailAndPassword(
      RegisterAuth regoister) async {
    try {
      final result =
          await datasource.registerWithEmailAndPassword(regoister: regoister);
      return Right(result);
    } on ServerException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerException(message: "Erro no servidor"));
    }
  }
}
