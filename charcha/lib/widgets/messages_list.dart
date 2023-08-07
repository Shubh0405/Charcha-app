import 'package:charcha/models/chat_alerts.dart';
import 'package:charcha/models/message.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatelessWidget {
  final List<dynamic> messagesList;

  const MessagesList({super.key, required this.messagesList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messagesList.length,
        itemBuilder: (context, index) {
          var message = messagesList[index];
          if (message is ChatAlerts) {
            return ChatAlertWidget(alert: message.alert);
          } else if (message is Message) {
            return MessageWidget(message: message);
          } else {
            return const SizedBox.shrink();
          }
        });
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

  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
      alignment:
          message.sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: deviceWidth * 0.6),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: message.sendByMe
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        child: Text(
          message.content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: message.sendByMe
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
