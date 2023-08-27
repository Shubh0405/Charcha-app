import 'package:charcha/res/ui_states.dart';
import 'package:charcha/services/user_service.dart';
import 'package:charcha/usecases/message_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessagesCubit extends Cubit<UIState> {
  ChatMessagesCubit() : super(LoadingState());

  Future<void> loadChatMessages(String chatId) async {
    try {
      final messagesResponse = await UserService.getChatMessages(chatId);

      final messageList =
          await MessageListUseCase().execute(messagesResponse["data"]);

      emit(SuccessState<List<dynamic>>(messageList));
    } catch (e) {
      print(e);
      emit(FailureState(
          UiError(message: "Some error occured! Couldn't load the messages!")));
    }
  }
}
