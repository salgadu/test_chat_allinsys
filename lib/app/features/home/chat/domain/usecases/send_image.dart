import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';
import 'package:mensageiro/app/features/home/chat/domain/repository/chat_repository.dart';


abstract class ISendImage {
  Future<Either<Failure, Unit>> call(String id, Chat chat, Uint8List image);
}

class SendImageImpl implements ISendImage {
  final IChatRepository repository;
  SendImageImpl(this.repository);
  @override
  Future<Either<Failure, Unit>> call(
    String id, Chat chat, Uint8List image) async {
    return await repository.sendImage(id, chat, image);
  }
}