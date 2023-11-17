import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';

abstract class IChatRepository {
  Stream<List<Chat>> getMessages(String id);
  Future<Either<Failure, Unit>> sendMessage(String id, Chat chat);
  Future<Either<Failure, Unit>> sendAudio(
      String id, Chat chat, Uint8List audio);
  Future<Either<Failure, Unit>> sendImage(
      String id, Chat chat, Uint8List image);
  Future<Either<Failure, Unit>> sendVideo(
      String id, Chat chat, Uint8List video);
  Future<Either<Failure, Unit>> sendDocument(
      String id, Chat chat, Uint8List document);
}
