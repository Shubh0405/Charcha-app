import 'package:charcha/models/chat_alerts.dart';
import 'package:charcha/usecases/charcha_usecases.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:charcha/res/shared_preferences_strings.dart';

import '../models/message.dart';
import '../models/user.dart';

class MessageListUseCase implements IMessageListUseCase {
  @override
  Future<List<dynamic>> execute(List<dynamic> input) async {
    List<dynamic> messageList = [];

    final prefs = await SharedPreferences.getInstance();
    String? userProfileId = prefs.getString(prefs_string_user_profile_id);

    String lastDate = formatDate(input[0]["createdAt"]);
    ChatAlerts firstAlert = ChatAlerts(alert: lastDate);

    messageList.add(firstAlert);

    for (var message in input) {
      String messageDate = formatDate(message["createdAt"]);

      if (messageDate != lastDate) {
        ChatAlerts newAlert = ChatAlerts(alert: messageDate);
        messageList.add(newAlert);
        lastDate = messageDate;
      }

      String messageId = message["_id"];
      String chatId = message["chat"];

      String senderId = message["from"]["_id"];
      User sender = User(
          userId: senderId,
          userName: message["from"]["username"],
          fullName: message["from"]["fullName"]);

      bool sendByMe = false;
      if (senderId == userProfileId) {
        sendByMe = true;
      }

      String messageTime = formatTime(message["createdAt"]);
      String content = message["content"];
      List<dynamic> readBy = message["readBy"];

      bool isDeletedForMe = false;
      if ((message["isDeletedForMe"] as List).contains(userProfileId)) {
        isDeletedForMe = true;
      }

      bool isEdited = message["isEdited"];
      bool isDeleted = message["isDeleted"];

      Message messageObject = Message(
          messageId: messageId,
          chatId: chatId,
          sender: sender,
          sendByMe: sendByMe,
          messageDate: messageDate,
          messageTime: messageTime,
          content: content,
          readBy: readBy,
          isDeleted: isDeleted,
          isDeletedForMe: isDeletedForMe,
          isEdited: isEdited);

      messageList.add(messageObject);
    }

    return messageList;
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString).toLocal();
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  String formatTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString).toLocal();
    String period = dateTime.hour >= 12 ? 'PM' : 'AM';
    int hour = dateTime.hour % 12;
    hour = hour == 0 ? 12 : hour;
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute $period";
  }
}
