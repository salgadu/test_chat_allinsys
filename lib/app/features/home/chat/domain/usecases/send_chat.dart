import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';
import 'package:mensageiro/app/features/home/chat/domain/repository/chat_repository.dart';

abstract class ISendChat {
  Future<Either<Failure, Unit>> call(String id, Chat chat);
}

class SendChatImpl implements ISendChat {
  final IChatRepository repository;
  SendChatImpl(this.repository);
  @override
  Future<Either<Failure, Unit>> call(String id, Chat chat) async {
    return await repository.sendMessage(id, chat);
  }
}
