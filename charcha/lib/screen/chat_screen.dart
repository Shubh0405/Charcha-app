import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String chatProfilePic;
  final String chatName;

  const ChatScreen(
      {super.key,
      this.chatId = "",
      required this.chatProfilePic,
      required this.chatName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: Text("Messages"),
          )),
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
                        maxLines: null,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: deviceWidth * 0.05,
                      child: const Icon(Icons.send_outlined),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
