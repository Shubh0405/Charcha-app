import 'package:charcha/models/message.dart';

class UserChats {
  final String chatId;
  final bool isPersonalChat;
  final String chatProfilePic;
  final String chatName;
  final String latestMessage;
  final String latestMessageSender;
  final String latestMessageTime;
  final bool readByAll;

  UserChats(
      {required this.chatId,
      required this.isPersonalChat,
      required this.chatProfilePic,
      required this.chatName,
      required this.latestMessage,
      required this.latestMessageSender,
      required this.latestMessageTime,
      required this.readByAll});
}
