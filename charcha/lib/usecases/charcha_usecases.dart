import 'package:charcha/models/user_chats.dart';
import 'package:charcha/res/iusecase.dart';

abstract class IChatListUseCase
    implements IUseCaseAsync<List<dynamic>, List<UserChats>> {}

abstract class IUpdateChatListUseCase
    implements
        IMultipleInputUseCaseAsync<List<UserChats>, Map<String, dynamic>,
            List<UserChats>> {}

abstract class IMessageListUseCase
    implements IUseCaseAsync<List<dynamic>, List<dynamic>> {}

abstract class IAddMessageUseCase
    implements IUseCaseAsync<Map<String, dynamic>, List<dynamic>> {}

abstract class IMessageReadUseCase
    implements IMultipleInputUseCase<List<dynamic>, String, List<dynamic>> {}
