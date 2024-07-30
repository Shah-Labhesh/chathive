import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final String time;

  ChatMessage({required this.text, required this.isUser, required this.time});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
              minWidth: MediaQuery.of(context).size.width * 0.2,
            ),
            margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isUser ? theme.colorScheme.tertiaryContainer : theme.colorScheme.onTertiaryContainer,
              borderRadius: BorderRadius.only(
                topLeft: isUser
                    ? const Radius.circular(10)
                    : const Radius.circular(0),
                bottomLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomRight: isUser
                    ? const Radius.circular(0)
                    : const Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: isUser ? theme.colorScheme.tertiary : theme.colorScheme.onTertiary,
                    fontSize: 14,
                    fontFamily: 'Chillax-medium',
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: isUser ? theme.colorScheme.tertiary : theme.colorScheme.onTertiary,
                        fontSize: 12,
                        fontFamily: 'Chillax-regular'
                      ),
                      textAlign: isUser ? TextAlign.right : TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
