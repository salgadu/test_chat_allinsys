import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mensageiro/app/core/utils/rash_id.dart';
import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';
import 'package:mensageiro/app/features/home/chat/infra/datasource/i_chat_datasource.dart';
import 'package:mensageiro/app/features/home/chat/infra/model/chat_model.dart';

class FirebaseDatasourceChats implements IChatDatasource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FirebaseDatasourceChats({required this.firestore, required this.storage});

  @override
  Stream<List<ChatModel>> getMessages(String id) {
    return firestore
        .collection('chats')
        .doc(id.calculateHash())
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return ChatModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  @override
  Future<void> sendChat(String id, Chat chat) async {
    try {
      final chatCollection = firestore
          .collection('chats')
          .doc(id.calculateHash())
          .collection('messages');
      await chatCollection.add({
        'message': chat.message,
        'timestamp': chat.timestamp,
        'userId': chat.userId,
        'typeMessage':chat.typeMessage
      });
    } catch (e) {
      print("Error adding message: $e");
      throw ChatException("Error adding message: $e");
    }
  }

  @override
  Future<void> sendAudio(String id, Chat chat, Uint8List audio) async {
    try {
      final audioStorageRef =
          storage.ref().child('${chat.userId}/audio/${chat.message}.wav');
      await audioStorageRef.putData(audio);
      final downloadUrl = await audioStorageRef.getDownloadURL();
      //Adiciono a url na message do audio
      chat.message = downloadUrl;
      return await sendChat(id, chat);
    } catch (error) {
      print("Error uploading audio file: $error");
      throw ChatException("Error adding audio: $error");
    }
  }

  @override
  Future<void> sendDocument(String id, Chat chat, Uint8List document) async {
    try {
      final documentStorageRef =
          storage.ref().child('${chat.userId}/document/${chat.message}.pdf');
      await documentStorageRef.putData(document);
      final downloadUrl = await documentStorageRef.getDownloadURL();
      //Adiciono a url na message do document
      chat.message = downloadUrl;
      return await sendChat(id, chat);
    } catch (error) {
      print("Error uploading document file: $error");
      throw ChatException("Error adding document: $error");
    }
  }

  @override
  Future<void> sendImage(String id, Chat chat, Uint8List image) async {
    try {
      final imageStorageRef =
          storage.ref().child('${chat.userId}/image/${chat.message}.jpg');
      await imageStorageRef.putData(image);
      final downloadUrl = await imageStorageRef.getDownloadURL();
      //Adiciono a url na message da imagem
      chat.message = downloadUrl;
      return await sendChat(id, chat);
    } catch (error) {
      print("Error uploading image file: $error");
      throw ChatException("Error adding image: $error");
    }
  }

  @override
  Future<void> sendVideo(String id, Chat chat, Uint8List video) async {
    try {
      final videoStorageRef =
          storage.ref().child('${chat.userId}/video/${chat.message}.mp4');
      await videoStorageRef.putData(video);
      final downloadUrl = await videoStorageRef.getDownloadURL();
      //Adiciono a url na message do video
      chat.message = downloadUrl;
      return await sendChat(id, chat);
    } catch (error) {
      print("Error uploading video file: $error");
      throw ChatException("Error adding video: $error");
    }
  }
}

class ChatException implements Exception {
  final String message;

  ChatException(this.message);

  @override
  String toString() {
    return 'ChatException: $message';
  }
}
