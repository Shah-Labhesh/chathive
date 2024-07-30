import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/constants/App_colors.dart';

class ChatAppBar extends StatelessWidget {
  final String? userName;

  const ChatAppBar({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      color: theme.appBarTheme.backgroundColor,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey[400]!,
                  width: 0.2,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: theme.appBarTheme.actionsIconTheme!.color,
                size: theme.appBarTheme.actionsIconTheme!.size,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: IntialAvatar(
              height: 50,
              width: 50,
              username: userName ?? 'L',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              userName ?? 'No user',
              style: theme.textTheme.labelMedium!.copyWith(
                letterSpacing: 0.5,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 10),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          //   child: const Icon(
          //     Icons.more_vert_rounded,
          //     color: Colors.black,
          //     size: 20,
          //   ),
          // ),
        ],
      ),
    );
  }
}

Widget IntialAvatar({
  required double height,
  required double width,
  required String username,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.usernameColors[username[0].toUpperCase()],
    ),
    child: Center(
      child: Text(
        username[0].toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Chillax-semibold',
        ),
      ),
    ),
  );
}
