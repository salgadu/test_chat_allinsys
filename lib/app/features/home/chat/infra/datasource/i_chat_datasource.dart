import 'dart:typed_data';

import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';

abstract class IChatDatasource {
  Stream<List<Chat>> getMessages(String id);
  Future<void> sendChat(String id, Chat chat);
  Future<void> sendAudio(String id, Chat chat, Uint8List audio);
  Future<void> sendImage(String id, Chat chat, Uint8List image);
  Future<void> sendVideo(String id, Chat chat, Uint8List video);
  Future<void> sendDocument(String id, Chat chat, Uint8List document);
}
