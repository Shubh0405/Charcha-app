class UserChats {
  final String chatId;
  final bool isPersonalChat;
  final String chatProfilePic;
  final String chatName;
  String latestMessage;
  String latestMessageSender;
  String latestMessageTime;
  bool readByAll;

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
