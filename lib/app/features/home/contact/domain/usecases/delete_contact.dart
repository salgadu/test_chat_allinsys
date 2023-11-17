import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/contact/domain/repository/contact_repository.dart';

abstract class IDeleteContact {
  Future<Either<Failure, bool>> deleteContact(String id);
}

class DeleteContactImpl implements IDeleteContact {
  final IContactRepository repository;
  DeleteContactImpl(this.repository);
  @override
  Future<Either<Failure, bool>> deleteContact(String id) {
    return repository.deleteContact(id);
  }
}
