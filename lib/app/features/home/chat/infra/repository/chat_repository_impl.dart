import 'dart:async';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mensageiro/app/core/errors/errors.dart';
import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';
import 'package:mensageiro/app/features/home/chat/domain/repository/chat_repository.dart';
import 'package:mensageiro/app/features/home/chat/infra/datasource/i_chat_datasource.dart';

class ChatRepositoryImpl implements IChatRepository {
  final IChatDatasource _dataSource;

  ChatRepositoryImpl(this._dataSource);

  @override
  Stream<List<Chat>> getMessages(String id) {
    final controller = StreamController<List<Chat>>();

    _dataSource.getMessages(id).listen(
      (List<Chat> chats) {
        controller.add(chats);
      },
      onError: (error) {
        controller
            .addError(ServerException(message: "Error fetching chats: $error"));
      },
      onDone: () {
        controller.close();
      },
      cancelOnError: true,
    );
    return controller.stream;
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(String id, Chat chat) async {
    try {
      await _dataSource.sendChat(id, chat);
      return const Right(unit);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Unit>> sendAudio(
      String id, Chat chat, Uint8List audio) async {
    try {
      await _dataSource.sendAudio(id, chat, audio);
      return const Right(unit);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Unit>> sendDocument(
      String id, Chat chat, Uint8List document) async {
    try {
      await _dataSource.sendDocument(id, chat, document);
      return const Right(unit);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Unit>> sendImage(
      String id, Chat chat, Uint8List image) async {
    try {
      await _dataSource.sendImage(id, chat, image);
      return const Right(unit);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Unit>> sendVideo(
      String id, Chat chat, Uint8List video) async {
    try {
      await _dataSource.sendVideo(id, chat, video);
      return const Right(unit);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
