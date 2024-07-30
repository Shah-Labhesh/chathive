import 'package:flutter/material.dart';

class CustomMessageInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSendPressed;

  const CustomMessageInput({
    super.key,
    required this.controller,
    required this.onSendPressed,
  });

  @override
  _CustomMessageInputState createState() => _CustomMessageInputState();
}

class _CustomMessageInputState extends State<CustomMessageInput> {
  bool isFocusCustom = false;

  void _changeFocus(bool focus) {
    setState(() {
      isFocusCustom = focus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Focus(
      onFocusChange: _changeFocus,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.onSecondaryContainer,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSecondaryFixed.withOpacity(0.08),
              spreadRadius: 4,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: widget.controller,
                  onFieldSubmitted: (value) {
                    widget.onSendPressed();
                  
                  },
                  onTap: () {
                    widget.controller.selection = TextSelection.fromPosition(
                      TextPosition(
                        offset: widget.controller.text.length,
                      ),
                    );
                  },
                  maxLines: isFocusCustom ? null : 1,
                  autofocus: isFocusCustom,
                  
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: theme.colorScheme.onSecondary,
                    fontSize: 16,
                    fontFamily: 'Chillax-medium',
                  ),
                  cursorColor: theme.colorScheme.onSecondary,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: theme.colorScheme.onSecondaryFixedVariant,
                      fontSize: 16,
                      fontFamily: 'Chillax-medium',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: widget.onSendPressed,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSecondaryFixed,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.send,
                  color: theme.colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
