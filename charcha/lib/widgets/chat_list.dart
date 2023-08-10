import 'package:charcha/cubits/user_chat_cubit.dart';
import 'package:charcha/models/user_chats.dart';
import 'package:charcha/res/ui_states.dart';
import 'package:charcha/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatList extends StatefulWidget {
  final Function loadChats;

  const ChatList({super.key, required this.loadChats});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserChatCubit, UIState>(builder: (context, state) {
      print(state);
      if (state is LoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SuccessState<List<UserChats>>) {
        return ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              UserChats userChat = state.data[index];

              return GestureDetector(
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                            chatId: userChat.chatId,
                            chatProfilePic: userChat.chatProfilePic,
                            chatName: userChat.chatName),
                      )).then((value) {
                    print("Chat Screen Poped!");
                    widget.loadChats();
                  });
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: (userChat.chatProfilePic != "")
                        ? NetworkImage(userChat.chatProfilePic)
                        : const AssetImage("assets/images/user_avatar.png")
                            as ImageProvider,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    radius: 20,
                  ),
                  title: Text(
                    userChat.chatName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  subtitle: Text(
                    userChat.latestMessageSender != ""
                        ? '${userChat.latestMessageSender}: ${userChat.latestMessage}'
                        : '${userChat.latestMessage}',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                    maxLines: 1,
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${userChat.latestMessageTime}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              );
            });
      } else {
        return Center(
          child: Text('Error'),
        );
      }
    });
  }
}
