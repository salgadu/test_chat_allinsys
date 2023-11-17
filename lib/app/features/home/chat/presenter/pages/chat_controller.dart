import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/core/infra/file_acess/i_file_access.dart';
import 'package:mensageiro/app/core/store/auth/auth_store.dart';
import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';
import 'package:mensageiro/app/features/home/chat/domain/usecases/get_message.dart';
import 'package:mensageiro/app/features/home/chat/domain/usecases/send_audio.dart';
import 'package:mensageiro/app/features/home/chat/domain/usecases/send_chat.dart';
import 'package:mensageiro/app/features/home/chat/domain/usecases/send_document.dart';
import 'package:mensageiro/app/features/home/chat/domain/usecases/send_image.dart';
import 'package:mobx/mobx.dart';

part 'chat_controller.g.dart';

class ChatController = ChatControllerBase with _$ChatController;

abstract class ChatControllerBase with Store {
  final IGetMessage getMessage;
  final ISendChat sendMessages;
  final ISendAudio sendAudios;
  final ISendImage sendImages;
  final IFileAccess fileAccess;
  final ISendDocument sendDocuments;
  final AuthStore _authStore = Modular.get<AuthStore>();

  ChatControllerBase(this.sendMessages, this.getMessage, this.sendAudios, this.sendImages, this.sendDocuments, this.fileAccess);

  Future sendMessage(String id, Chat message) async {
    message.userId = _authStore.user!.phoneNumber;
    final idChat = '$id${_authStore.user!.phoneNumber}';
    var result = await sendMessages(idChat, message);
    result.fold((l) {}, (r) {});
  }

  Stream<List<Chat>> messages(String id) {
    final idChat = '$id${_authStore.user!.phoneNumber}';
    return getMessage(idChat);
  }

  Future sendAudio(String id, String pathAudio) async {   
    Uint8List? audio;

     File file = File(pathAudio);
  List<int> bytes = await file.readAsBytes();

   audio = Uint8List.fromList(bytes);   
    final chat = Chat(
      message: DateTime.now().toString() ,
      userId: _authStore.user!.phoneNumber,
      timestamp: DateTime.now().toString(),
      typeMessage: 'A',
    );
    final idChat = '$id${_authStore.user!.phoneNumber}';
    var result = await sendAudios(idChat, chat, audio);
    result.fold((l) {}, (r) {});
  }

  Future sendDocument(String id) async {
    Uint8List? document;
    final resultDocument = await fileAccess.pickDocument();
    resultDocument.fold((l) => l, (r) => document = r);
    if (document == null) {
      print("Document not selected");
      return;
    }
    final chat = Chat(
       message: DateTime.now().toString() ,
      userId: _authStore.user!.phoneNumber,
      timestamp: DateTime.now().toString(),
      typeMessage: 'D',
    );
    final idChat = '$id${_authStore.user!.phoneNumber}';
    var result = await sendDocuments(idChat, chat, document!);
    result.fold((l) {}, (r) {});
  }

  Future sendImage(String id) async {
    String image = '';
    final resultImage = await fileAccess.pickImageBase64();
    resultImage.fold((l) => l, (r) => image = r ?? '');
    if (image.isEmpty) {
      print("Image not selected");
      return;
    }
    final chat = Chat(
       message: DateTime.now().toString() ,
      userId: _authStore.user!.phoneNumber,
      timestamp: DateTime.now().toString(),
      typeMessage: 'P',
    );
    final idChat = '$id${_authStore.user!.phoneNumber}';
    var result = await sendImages(idChat, chat, base64Decode(image));
    result.fold((l) {}, (r) {});
  }
}
