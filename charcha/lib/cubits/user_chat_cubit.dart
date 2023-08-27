import 'package:charcha/models/user_chats.dart';
import 'package:charcha/res/ui_states.dart';
import 'package:charcha/services/auth_service.dart';
import 'package:charcha/services/user_service.dart';
import 'package:charcha/usecases/chat_list_usecase.dart';
import 'package:charcha/usecases/update_chat_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserChatCubit extends Cubit<UIState> {
  List<UserChats> userChatsList = [];

  UserChatCubit() : super(LoadingState());

  Future<void> updateUserChatList(Map<String, dynamic> newMessage) async {
    print("INSIDE UPDATE USER CHAT LIST CUBIT");

    List<UserChats> newChatList =
        await UpdateChatListUseCase().execute(userChatsList, newMessage);

    userChatsList = newChatList;

    emit(LoadingState());

    emit(SuccessState<List<UserChats>>(userChatsList));
  }

  Future<void> loadUserChats() async {
    try {
      final chatResponse = await UserService.getUserChats();
      print("Inside Cubit");

      userChatsList = await ChatListUseCase().execute(chatResponse["data"]);

      emit(SuccessState<List<UserChats>>(userChatsList));
    } catch (e) {
      print(e);
      emit(FailureState(
          UiError(message: "Some error occured! Couldn't load the chats!")));
    }
  }
}
