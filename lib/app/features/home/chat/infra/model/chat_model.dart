import 'package:mensageiro/app/features/home/chat/domain/entity/chat.dart';

class ChatModel extends Chat {
  ChatModel({
    required super.id,
    required super.message,
    required super.timestamp,
    required super.userId,
    required super.typeMessage,
  
  });

  factory ChatModel.fromMap(String id, Map<String, dynamic> map) {
    return ChatModel(
        id: id,
        message: map['message'],
        timestamp: map['timestamp'].toString(),
        userId: map['userId'],
        typeMessage: map['typeMessage'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'timestamp': timestamp,
      'userId': userId,
      'typeMessage': typeMessage
    };
  }
}
