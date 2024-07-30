// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.autofillHints,
    this.inputFormatters,
    this.keyboardAppearance,
    this.keyboardType,
    this.readOnly = false,
    required this.focusNode,
    this.validator,
    this.suffixIcon,
    this.onSuffixPressed,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final Brightness? keyboardAppearance;
  final TextInputType? keyboardType;
  final bool readOnly;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Function()? onSuffixPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: theme.colorScheme.shadow),
    );
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      autofillHints: autofillHints,
      cursorColor: theme.colorScheme.surface,
      inputFormatters: inputFormatters,
      keyboardAppearance: keyboardAppearance,
      keyboardType: keyboardType,
      readOnly: readOnly,
      focusNode: focusNode,
      onTapOutside: (event) => focusNode.unfocus(),
      validator: validator,
      obscuringCharacter: '*',
      style: theme.textTheme.displayMedium!.copyWith(
        fontSize: 16,
      ),
      
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        border: border,
        disabledBorder: border,
        focusedErrorBorder: border,
        fillColor: theme.colorScheme.shadow,
        filled: true,
        hintText: hintText,
        hintStyle: theme.textTheme.displaySmall!.copyWith(
          fontSize: 16,
        ),
        errorStyle: TextStyle(
          fontSize: 14,
          fontFamily: 'Chillax-medium',
          color: Colors.red.shade900,
        ),
        enabled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onSuffixPressed,
                icon: suffixIcon!,
              )
            : null,
      ),
    );
  }
}
