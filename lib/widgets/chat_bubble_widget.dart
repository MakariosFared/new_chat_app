import 'package:flutter/material.dart';
import 'package:my_chat_app/models/message.dart';
import '../const.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          left: 18,
          bottom: 32,
          top: 32,
          right: 24,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            )),
        child: Text(
            message.message,
            style: const TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          left: 18,
          bottom: 32,
          top: 32,
          right: 24,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        decoration: const BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            )),
        child: Text(
            message.message,
            style: const TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}

