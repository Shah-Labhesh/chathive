// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6),
          color: theme.colorScheme.onSurface,
        ),
        child: Text(
          title,
          style: theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
