import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';
import 'package:mensageiro/app/features/home/chat/domain/repository/chat_repository.dart';

abstract class ISendAudio {
  Future<Either<Failure, Unit>> call(String id, Chat chat, Uint8List audio);
}

class SendAudioImpl implements ISendAudio {
  final IChatRepository repository;
  SendAudioImpl(this.repository);
  @override
  Future<Either<Failure, Unit>> call(
    String id, Chat chat, Uint8List audio) async {
    return await repository.sendAudio(id, chat, audio);
  }
}
