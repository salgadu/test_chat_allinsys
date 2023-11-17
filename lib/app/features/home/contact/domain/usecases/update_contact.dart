import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/contact/domain/entity/contact.dart';
import 'package:mensageiro/app/features/home/contact/domain/repository/contact_repository.dart';

abstract class IUpdateContact {
  Future<Either<Failure, bool>> updateContact(String id, Contact contact);
}

class UpdateContactImpl implements IUpdateContact {
  final IContactRepository repository;
  UpdateContactImpl(this.repository);
  @override
  Future<Either<Failure, bool>> updateContact(String id, Contact contact) {
    return repository.updateContact(id, contact);
  }
}
