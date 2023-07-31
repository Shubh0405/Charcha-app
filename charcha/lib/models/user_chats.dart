import 'package:charcha/models/message.dart';

class UserChats {
  final String chatId;
  final bool isPersonalChat;
  final String chatProfilePic;
  final String chatName;
  final Message latestMessage;
  final String latestMessageSender;
  final bool readByAll;

  UserChats(
      {required this.chatId,
      required this.isPersonalChat,
      required this.chatProfilePic,
      required this.chatName,
      required this.latestMessage,
      required this.latestMessageSender,
      required this.readByAll});
}
