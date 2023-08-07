import 'package:charcha/models/user.dart';

class Message {
  final String messageId;
  final String chatId;
  final User sender;
  final bool sendByMe;
  final String messageDate;
  final String messageTime;
  String content;
  List<dynamic> readBy;
  bool isDeletedForMe;
  bool isDeleted;
  bool isEdited;

  Message(
      {required this.messageId,
      required this.chatId,
      required this.sender,
      required this.sendByMe,
      required this.messageDate,
      required this.messageTime,
      required this.content,
      required this.readBy,
      this.isDeletedForMe = false,
      this.isDeleted = false,
      this.isEdited = false});
}
