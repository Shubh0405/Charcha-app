import 'package:charcha/cubits/chat_messages_cubit.dart';
import 'package:charcha/models/message.dart';
import 'package:charcha/res/socket_constants.dart';
import 'package:charcha/res/ui_states.dart';
import 'package:charcha/services/user_service.dart';
import 'package:charcha/sockets/socket.dart';
import 'package:charcha/usecases/add_message_usecase.dart';
import 'package:charcha/utils/globals.dart';
import 'package:charcha/widgets/messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String userId;
  final String chatProfilePic;
  final String chatName;

  const ChatScreen(
      {super.key,
      this.chatId = "",
      this.userId = "",
      required this.chatProfilePic,
      required this.chatName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final socket = SocketSingleton().socket;
  final TextEditingController _textController = TextEditingController();
  List<dynamic> messagesList = [];
  bool? newChat;
  String? initChatId;

  @override
  void initState() {
    // TODO: implement initState
    initChatId = widget.chatId;
    newChat = (widget.chatId == "") ? true : false;
    if (newChat != null && newChat == false) {
      _loadMessages();
    }
    _listenChatSockets();
    super.initState();
  }

  @override
  void dispose() {
    // Unsubscribe from socket events when disposing
    socket.off(socket_event_new_message);
    super.dispose();
  }

  Future<void> _loadMessages() async {
    await BlocProvider.of<ChatMessagesCubit>(context)
        .loadChatMessages(initChatId!);
  }

  Future<void> _sendMessage() async {
    if (_textController.text == "") {
      return;
    }

    Map<String, dynamic> newMessage;
    try {
      if (newChat == false) {
        newMessage =
            await UserService.sendMessage(initChatId!, _textController.text);
      } else {
        newMessage = {};
      }
    } catch (e) {
      print(e);
      snackbarKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text("Some error occured in sending the message!"),
        ),
      );
      return;
    }

    newMessage["data"]["lastMessage"] =
        (newChat == true) ? null : messagesList.last.messageDate;

    List<dynamic> newMessageList =
        await AddMessageUseCase().execute(newMessage["data"]);

    setState(() {
      messagesList.addAll(newMessageList);
      _textController.clear();
    });
  }

  Future<void> _listenChatSockets() async {
    socket.on(socket_event_new_message, (message) async {
      if (message["chat"] == initChatId) {
        message["lastMessage"] =
            (newChat == true) ? null : messagesList.last.messageDate;

        List<dynamic> newMessageList =
            await AddMessageUseCase().execute(message);

        setState(() {
          messagesList.addAll(newMessageList);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                splashColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios)),
            CircleAvatar(
              backgroundImage: (widget.chatProfilePic != "")
                  ? NetworkImage(widget.chatProfilePic)
                  : const AssetImage("assets/images/user_avatar.png")
                      as ImageProvider,
              backgroundColor: Theme.of(context).colorScheme.background,
              radius: 15,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.chatName,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body:
          BlocConsumer<ChatMessagesCubit, UIState>(listener: (context, state) {
        if (state is SuccessState<List<dynamic>>) {
          setState(() {
            messagesList = state.data;
          });
        } else if (state is FailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error.toString())));
        }
      }, builder: (context, state) {
        return Column(
          children: [
            Expanded(child: MessagesList(messagesList: messagesList)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surface, // Set the background color
                        borderRadius:
                            BorderRadius.circular(8), // Set the border radius
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: 150, maxWidth: deviceWidth * 0.8),
                        child: TextFormField(
                          controller: _textController,
                          maxLines: null,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface), // Set the text color
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              labelText: 'Message',
                              labelStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: GestureDetector(
                        onTap: () {
                          _sendMessage();
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          radius: deviceWidth * 0.05,
                          child: const Icon(Icons.send_outlined),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
