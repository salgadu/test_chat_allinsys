import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/contact/domain/entity/contact.dart';

abstract class IContactRepository {
  Future<Either<Failure, List<Contact>>> getContacts(String uid);
  Future<Either<Failure, List<Contact>>> addContact(String id, Contact contact);
  Future<Either<Failure, bool>> deleteContact(String id);
  Future<Either<Failure, bool>> updateContact(String id, Contact contact);
}
