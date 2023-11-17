import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/contact/domain/entity/contact.dart';
import 'package:mensageiro/app/features/home/contact/domain/repository/contact_repository.dart';
import 'package:mensageiro/app/features/home/contact/infra/datasource/i_contact_datasource.dart';

class ContactRepositoryImpl implements IContactRepository {
  final IContactDatasource datasource;
  ContactRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, List<Contact>>> getContacts(String uid) async {
    try {
      final result = await datasource.getContacts(uid);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> addContact(
      String id, Contact contact) async {
    try {
      final result = await datasource.addContact(id, contact);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteContact(String id) async {
    try {
      final result = await datasource.deleteContact(id);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> updateContact(
      String id, Contact contact) async {
    try {
      final result = await datasource.updateContact(id, contact);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
