import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';
import 'package:mensageiro/app/features/home/chat/domain/repository/chat_repository.dart';

abstract class ISendDocument {
  Future<Either<Failure, Unit>> call(String id, Chat chat, Uint8List document);
}

class SendDocumentImpl implements ISendDocument {
  final IChatRepository repository;
  SendDocumentImpl(this.repository);
  @override
  Future<Either<Failure, Unit>> call(
      String id, Chat chat, Uint8List document) async {
    return await repository.sendDocument(id, chat, document);
  }
}