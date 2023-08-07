import 'package:charcha/models/user_chats.dart';
import 'package:charcha/res/ui_states.dart';
import 'package:charcha/services/auth_service.dart';
import 'package:charcha/services/user_service.dart';
import 'package:charcha/usecases/chat_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserChatCubit extends Cubit<UIState> {
  UserChatCubit() : super(LoadingState());

  Future<void> loadUserChats() async {
    try {
      final chatResponse = await UserService.getUserChats();
      print("Inside Cubit");

      List<UserChats> userChats =
          await ChatListUseCase().execute(chatResponse["data"]);

      print(userChats);

      emit(SuccessState<List<UserChats>>(userChats));
    } catch (e) {
      print(e);
      emit(FailureState(
          UiError(message: "Some error occured! Couldn't load the chats!")));
    }
  }
}
