import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/contact/domain/entity/contact.dart';
import 'package:mensageiro/app/features/home/contact/domain/repository/contact_repository.dart';

abstract class IGetContacts {
  Future<Either<Failure, List<Contact>>> call({required String uid});
}

class GetContactImpl implements IGetContacts {
  final IContactRepository repository;
  GetContactImpl(this.repository);
  @override
  Future<Either<Failure, List<Contact>>> call({required String uid}) {
    return repository.getContacts(uid);
  }
}