import 'package:charcha/models/user_chats.dart';
import 'package:charcha/res/iusecase.dart';

abstract class IChatListUseCase
    implements IUseCaseAsync<List<dynamic>, List<UserChats>> {}
