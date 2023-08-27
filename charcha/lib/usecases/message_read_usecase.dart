import 'package:charcha/models/message.dart';
import 'package:charcha/usecases/charcha_usecases.dart';

class MessageReadUseCase implements IMessageReadUseCase {
  @override
  List<dynamic> execute(List<dynamic> messageList, String messageId) {
    for (int i = 0; i < messageList.length; i++) {
      if ((messageList[i] is Message) &&
          (messageList[i] as Message).messageId == messageId) {
        (messageList[i] as Message).readByAll = true;
      }
    }

    return messageList;
  }
}
