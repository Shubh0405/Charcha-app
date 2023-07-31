import 'package:charcha/models/user.dart';

class Message {
  final String messageId;
  final String chatId;
  final User sender;
  final String messageDate;
  final String messageTime;
  String content;
  List<User> readBy = [];
  List<User> isDeletedForMe = [];
  bool isDeleted = false;
  bool isEdited = false;

  Message({
    required this.messageId,
    required this.chatId,
    required this.sender,
    required this.messageDate,
    required this.messageTime,
    required this.content,
  });
}
