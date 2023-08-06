import 'package:charcha/models/user_chats.dart';
import 'package:charcha/res/shared_preferences_strings.dart';
import 'package:charcha/usecases/charcha_usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListUseCase implements IChatListUseCase {
  @override
  Future<List<UserChats>> execute(List<dynamic> input) async {
    print("INSIDE USECASE");

    List<UserChats> userChatsList = [];

    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(prefs_string_user_id);

    print(userId);

    for (var chat in input) {
      String chatId = chat["_id"];
      bool isPersonalChat = chat["isPersonalChat"];

      String chatProfilePic = "";
      String chatName = "";

      if (!isPersonalChat) {
        chatName = chat["groupName"];
        chatProfilePic =
            (chat.containsKey("groupIcon")) ? chat["groupIcon"] : "";
      } else {
        for (var member in chat["members"]) {
          if (member["user"] != userId) {
            chatName = member["fullName"]!;
            chatProfilePic =
                (member.containsKey("profilePic")) ? member["profilePic"]! : "";
          }
        }
      }

      String latestMessage = chat["latestMessage"]["content"];
      String latestMessageSender =
          (chat["latestMessage"]["from"]["user"] == userId)
              ? 'You'
              : (!isPersonalChat)
                  ? chat["latestMessage"]["from"]["username"]
                  : "";

      String latestMessageTime =
          formatDateOrTime(chat["latestMessage"]["createdAt"]);

      bool readByAll = ((chat["latestMessage"]["readBy"] as List).length ==
              ((chat["members"] as List).length - 1))
          ? true
          : false;

      UserChats userChat = UserChats(
          chatId: chatId,
          isPersonalChat: isPersonalChat,
          chatProfilePic: chatProfilePic,
          chatName: chatName,
          latestMessage: latestMessage,
          latestMessageSender: latestMessageSender,
          latestMessageTime: latestMessageTime,
          readByAll: readByAll);

      userChatsList.add(userChat);
    }

    print("CHATLIST INSIDE USECASE ====>");
    print(userChatsList);

    return userChatsList;
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
