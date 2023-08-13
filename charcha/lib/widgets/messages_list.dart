import 'package:charcha/models/chat_alerts.dart';
import 'package:charcha/models/message.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatefulWidget {
  final List<dynamic> messagesList;
  final Function messageSwipeAction;

  const MessagesList(
      {super.key,
      required this.messagesList,
      required this.messageSwipeAction});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset <=
        _scrollController.position.minScrollExtent) {
      setState(() {
        _showScrollButton = false;
      });
    } else {
      setState(() {
        _showScrollButton = true;
      });
    }
  }

  void _scrollToLastMessage() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        controller: _scrollController,
        reverse: true,
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.messagesList.length,
            itemBuilder: (context, index) {
              var message = widget.messagesList[index];
              if (message is ChatAlerts) {
                return ChatAlertWidget(alert: message.alert);
              } else if (message is Message) {
                return MessageWidget(
                  message: message,
                  messageSwipeAction: widget.messageSwipeAction,
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
      ),
      if (_showScrollButton)
        Positioned(
          bottom: 10,
          right: 10,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: IconButton(
              icon: Icon(Icons.arrow_downward_sharp),
              onPressed: _scrollToLastMessage,
              color: Colors.black,
            ),
          ),
        ),
    ]);
  }
}

class ChatAlertWidget extends StatelessWidget {
  final String alert;

  const ChatAlertWidget({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Text(
          alert,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final Message message;
  final Function messageSwipeAction;

  const MessageWidget(
      {super.key, required this.message, required this.messageSwipeAction});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onDoubleTap: () {
        String messageSender =
            message.sendByMe ? "You" : message.sender.fullName;
        messageSwipeAction(message.messageId, messageSender, message.content);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
        alignment:
            message.sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: message.sendByMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            message.parentMessageId != null
                ? Container(
                    constraints: BoxConstraints(maxWidth: deviceWidth * 0.6),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: message.sendByMe
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10),
                            topRight: const Radius.circular(10),
                            bottomLeft: message.sendByMe
                                ? const Radius.circular(10)
                                : const Radius.circular(0),
                            bottomRight: message.sendByMe
                                ? const Radius.circular(0)
                                : const Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.parentMessageSenderName!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: message.sendByMe
                                      ? Colors.white54
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          message.parentMessageContent!,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: message.sendByMe
                                      ? Colors.white54
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            Container(
              constraints: BoxConstraints(maxWidth: deviceWidth * 0.6),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: message.sendByMe
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: message.parentMessageId != null
                      ? BorderRadius.only(
                          topLeft: message.sendByMe
                              ? const Radius.circular(10)
                              : const Radius.circular(0),
                          topRight: message.sendByMe
                              ? const Radius.circular(0)
                              : const Radius.circular(10),
                          bottomLeft: const Radius.circular(10),
                          bottomRight: const Radius.circular(10))
                      : const BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: message.sendByMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: message.sendByMe
                            ? Colors.white
                            : Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    message.messageTime.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 8,
                        color: message.sendByMe
                            ? const Color.fromARGB(139, 255, 255, 255)
                            : Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
