import 'package:charcha/models/chat_alerts.dart';
import 'package:charcha/models/message.dart';
import 'package:charcha/models/user.dart';
import 'package:charcha/res/shared_preferences_strings.dart';
import 'package:charcha/usecases/charcha_usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMessageUseCase implements IAddMessageUseCase {
  Future<List<dynamic>> execute(Map<String, dynamic> input) async {
    List<dynamic> messageList = [];

    final prefs = await SharedPreferences.getInstance();
    String? userProfileId = prefs.getString(prefs_string_user_profile_id);

    final lastDate = input["lastMessage"];
    String currentDate = formatDate(input["createdAt"]);

    if (lastDate == null || (lastDate != null && lastDate != currentDate)) {
      ChatAlerts alert = ChatAlerts(alert: currentDate);
      messageList.add(alert);
    }

    String messageId = input["_id"];
    String chatId = input["chat"];

    String senderId = input["from"]["_id"];
    User sender = User(
        userId: senderId,
        userName: input["from"]["username"],
        fullName: input["from"]["fullName"]);

    bool sendByMe = false;
    if (senderId == userProfileId) {
      sendByMe = true;
    }

    String messageTime = formatTime(input["createdAt"]);
    String content = input["content"];
    List<dynamic> readBy = input["readBy"];
    bool readByAll = false;

    bool isDeletedForMe = false;
    bool isEdited = input["isEdited"];
    bool isDeleted = input["isDeleted"];

    String? parentMessageId;
    String? parentMessageContent;
    String? parentMessageSenderId;
    String? parentMessageSenderName;

    if (input["parentMessage"] != null) {
      parentMessageId = input["parentMessage"]["_id"];
      parentMessageContent = input["parentMessage"]["content"];
      parentMessageSenderId = input["parentMessage"]["from"]["_id"];
      parentMessageSenderName = parentMessageSenderId == userProfileId
          ? 'You'
          : input["parentMessage"]["from"]["fullName"];
    }

    Message messageObject = Message(
        messageId: messageId,
        chatId: chatId,
        sender: sender,
        sendByMe: sendByMe,
        messageDate: currentDate,
        messageTime: messageTime,
        content: content,
        readBy: readBy,
        readByAll: readByAll,
        isDeleted: isDeleted,
        isDeletedForMe: isDeletedForMe,
        isEdited: isEdited,
        parentMessageContent: parentMessageContent,
        parentMessageId: parentMessageId,
        parentMessageSenderId: parentMessageSenderId,
        parentMessageSenderName: parentMessageSenderName);

    messageList.add(messageObject);

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

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String day = now.day.toString();
    String month = now.month.toString();
    String year = now.year.toString();
    return '$day/$month/$year';
  }
}
