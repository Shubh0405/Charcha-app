import 'package:charcha/models/user_chats.dart';
import 'package:charcha/res/shared_preferences_strings.dart';
import 'package:charcha/usecases/charcha_usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateChatListUseCase implements IUpdateChatListUseCase {
  @override
  Future<List<UserChats>> execute(
      List<UserChats> initialUserChats, Map<String, dynamic> newMessage) async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(prefs_string_user_id);

    String latestMessageChatId = newMessage["chat"];
    String latestMessage = newMessage["content"];
    String latestMessageTime = formatDateOrTime(newMessage["createdAt"]);

    UserChats? updatedChat;

    initialUserChats.retainWhere((chat) {
      if (chat.chatId == latestMessageChatId) {
        updatedChat = chat;
        return false;
      }

      return true;
    });

    if (updatedChat == null) {
      return initialUserChats;
    }

    String latestMessageSender = newMessage["from"]["user"] == userId
        ? 'You'
        : (!(updatedChat!.isPersonalChat))
            ? newMessage["from"]["username"]
            : "";

    updatedChat!.latestMessage = latestMessage;
    updatedChat!.latestMessageSender = latestMessageSender;
    updatedChat!.latestMessageTime = latestMessageTime;

    initialUserChats.insert(0, updatedChat!);

    return initialUserChats;
  }

  String formatDateOrTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString).toLocal();
    DateTime now = DateTime.now();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return formatTime(dateTime);
    } else {
      return formatDate(dateTime);
    }
  }

  String formatDate(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  String formatTime(DateTime dateTime) {
    String period = dateTime.hour >= 12 ? 'PM' : 'AM';
    int hour = dateTime.hour % 12;
    hour = hour == 0 ? 12 : hour;
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute $period";
  }
}
