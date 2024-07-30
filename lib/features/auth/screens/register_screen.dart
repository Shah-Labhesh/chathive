// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:messaging_app/features/auth/services/auth_service.dart';
import 'package:messaging_app/utils/toast_utils.dart';
import 'package:messaging_app/widgets/custom_button.dart';
import 'package:messaging_app/widgets/custom_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function()? onTap;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void toggleObscurePassword(int i) {
    if (i == 1) {
      hidePassword = !hidePassword;
    } else {
      hideConfirmPassword = !hideConfirmPassword;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // logo
                const SizedBox(
                  height: 50,
                ),
                Icon(
                  CupertinoIcons.chat_bubble_text_fill,
                  size: 180,
                  color: theme.colorScheme.inverseSurface,
                ),
                // create account message
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Let\'s Create an new account for you!',
                  style: theme.textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                // email field
                const SizedBox(
                  height: 30,
                ),
                CustomField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  focusNode: emailNode,
                  autofillHints: const [AutofillHints.email],
                  keyboardAppearance: theme.brightness,
                  keyboardType: TextInputType.emailAddress,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Email address cannot be empty';
                    }
                    if (!p0.contains('@') || !p0.contains('.')) {
                      return 'Email address is not valid';
                    }
                    return null;
                  },
                ),
                // password field
                const SizedBox(
                  height: 20,
                ),
                CustomField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: hidePassword,
                  focusNode: passwordNode,
                  autofillHints: const [AutofillHints.newPassword],
                  keyboardAppearance: theme.brightness,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (p0.length < 8) {
                      return 'Password must be 8 characters long';
                    }
                    return null;
                  },
                  suffixIcon: hidePassword
                      ? Icon(
                          CupertinoIcons.eye_solid,
                          // size: 20,
                          color: theme.colorScheme.inversePrimary,
                        )
                      : Icon(
                          CupertinoIcons.eye_slash_fill,
                          // size: 20,
                          color: theme.colorScheme.inversePrimary,
                        ),
                  onSuffixPressed: () {
                    toggleObscurePassword(1);
                  },
                ),
                // confirm password field
                const SizedBox(
                  height: 20,
                ),
                CustomField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: hideConfirmPassword,
                  focusNode: confirmPasswordNode,
                  autofillHints: const [AutofillHints.newPassword],
                  keyboardAppearance: theme.brightness,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Confirm Password cannot be empty';
                    }
                    if (p0.length < 8) {
                      return 'Confirm Password must be 8 characters long';
                    }
                    return null;
                  },
                  suffixIcon: hideConfirmPassword
                      ? Icon(
                          CupertinoIcons.eye_solid,
                          // size: 20,
                          color: theme.colorScheme.inversePrimary,

                        )
                      : Icon(
                          CupertinoIcons.eye_slash_fill,
                          // size: 20,
                          color: theme.colorScheme.inversePrimary,

                        ),
                  onSuffixPressed: () {
                    toggleObscurePassword(2);
                  },
                ),
                // sign in button
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  title: 'Sign Up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        ToastUtils.show(context, 'Passwords do not match',
                            isSuccess: false);
                      } else {
                        final authService =
                            Provider.of<AuthService>(context, listen: false);
                        try {
                          authService.registerWithEmailAndPassword(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            context,
                          );
                        } catch (e) {
                          ToastUtils.show(context, e.toString(),
                              isSuccess: false);
                          print(e.toString());
                        }
                      }
                    }
                  },
                ),
                // not a member
                const SizedBox(
                  height: 15,
                ),
                Divider(
                  color: theme.dividerColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Already a Member? ',
                    style: theme.textTheme.titleSmall,
                    children: [
                      TextSpan(
                        text: 'Login Now',
                        style: theme.textTheme.titleMedium,
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onTap ?? () {},
                      ),
                    ],
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
