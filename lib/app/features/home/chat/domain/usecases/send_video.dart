import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';
import 'package:mensageiro/app/features/home/chat/domain/repository/chat_repository.dart';

abstract class ISendVideo {
  Future<Either<Failure, Unit>> call(String id, Chat chat, Uint8List video);
}

class SendVideoImpl implements ISendVideo {
  final IChatRepository repository;
  SendVideoImpl(this.repository);
  @override
  Future<Either<Failure, Unit>> call(
      String id, Chat chat, Uint8List video) async {
    return await repository.sendVideo(id, chat, video);
  }
}