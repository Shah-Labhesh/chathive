// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:messaging_app/features/auth/model/user.dart';
import 'package:messaging_app/features/message/widgets/chat_app_bar.dart';

class UserTile extends StatelessWidget {
  UserTile({
    Key? key,
    required this.user,
    this.onTap,
  }) : super(key: key);
  final Users user;

  final Function()? onTap;

  String timestampToDateTime(int seconds, int nanoseconds) {
    // Convert the seconds and nanoseconds to a DateTime object
    return formatTimestamp(DateTime.fromMillisecondsSinceEpoch(
        seconds * 1000 + nanoseconds ~/ 1000000));
  }

  String formatTimestamp(DateTime timestamp) {
    // Create a DateFormat instance with the desired format
    final DateFormat formatter = DateFormat('hh:mm a');

    // Format the timestamp
    return formatter.format(timestamp);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6),
          color: theme.cardColor,
        ),
        child: Row(
          children: [
            IntialAvatar(
              height: 50,
              width: 50,
              username: user.email.toString().split('@').first[0],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.email ?? '',
                    style: textTheme.displayMedium!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  if (user.lastMessage != null) ...[
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    Text(
                      "${_auth.currentUser!.uid == user.lastMessage!.senderId ? "You: " : ""}${user.lastMessage!.message}",
                      style: textTheme.displayMedium!.copyWith(
                        fontSize: 14,
                        fontFamily: 'Chillax-regular',
                      ),
                    ),
                  ]
                ],
              ),
            ),
            if (user.lastMessage != null) ...[
              const SizedBox(
                width: 12,
              ),
              Text(
                timestampToDateTime(user.lastMessage!.timestamp!.seconds,
                    user.lastMessage!.timestamp!.nanoseconds),
                style: textTheme.titleSmall!.copyWith(
                  fontSize: 12,
                  fontFamily: 'Chillax-medium',
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
