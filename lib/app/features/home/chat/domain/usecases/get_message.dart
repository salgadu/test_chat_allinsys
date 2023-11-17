import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';
import 'package:mensageiro/app/features/home/chat/domain/repository/chat_repository.dart';

abstract class IGetMessage {
  Stream<List<Chat>> call(String id);
}

class GetMessageImpl implements IGetMessage {
  final IChatRepository _repository;
  GetMessageImpl(this._repository);
  @override
  Stream<List<Chat>> call(String id) {
    return _repository.getMessages(id);
  }
}
