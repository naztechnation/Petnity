import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatefulWidget {
  final String message;
  final String author;
  final int createdAt;
  final bool isYourMessage;
  final int type;

  const MessageBubble({
    super.key,
    required this.message,
    required this.author,
    required this.createdAt,
    required this.isYourMessage,
    required this.type,
  });

  @override
  State createState() => _MessageBubbleState(
        message: message,
        author: author,
        createdAt: createdAt,
        isYourMessage: isYourMessage,
        type: type,
      );
}

class _MessageBubbleState extends State<MessageBubble> {
  final String message;
  final String author;
  final int createdAt;
  final bool isYourMessage;
  final int type;

  _MessageBubbleState({
    required this.message,
    required this.author,
    required this.createdAt,
    required this.isYourMessage,
    required this.type,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: (isYourMessage ? Alignment.centerRight : Alignment.centerLeft),
      margin: isYourMessage
          ? const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 60)
          : const EdgeInsets.only(top: 10, bottom: 10, right: 60, left: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: (isYourMessage
                ? Theme.of(context).dividerColor.withOpacity(0.2)
                : Theme.of(context).colorScheme.secondary.withOpacity(0.8)),
            borderRadius: BorderRadius.circular(8)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 150),
          child: Container(
            padding: const EdgeInsets.only(bottom: 4),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1.0)),
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                if (type == 1)
                  Text(
                    message,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                if (type == 2)
                  Image.network(
                    message,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / 10
                              : null,
                          backgroundColor: Colors.white,
                        ),
                      );
                    },
                  ),
                Transform.translate(
                  offset: const Offset(0, 25),
                  child: Text(
                    author,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Transform.translate(
                    offset: const Offset(0, 25),
                    child: Text(
                      DateFormat('hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(createdAt)),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
