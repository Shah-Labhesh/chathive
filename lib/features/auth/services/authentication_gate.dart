import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/features/auth/screens/home_screen.dart';
import 'package:messaging_app/features/auth/screens/login_screen.dart';
import 'package:messaging_app/features/auth/screens/register_screen.dart';

class AuthenticationGate extends StatefulWidget {
  const AuthenticationGate({super.key});

  @override
  State<AuthenticationGate> createState() => _AuthenticationGateState();
}

class _AuthenticationGateState extends State<AuthenticationGate> {
  bool showLoginScreen = true;

  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return HomeScreen();
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: showLoginScreen
                ? LoginScreen(
                    key: ValueKey('login'),
                    onTap: toggleScreen,
                  )
                : RegisterScreen(
                    key: ValueKey('register'),
                    onTap: toggleScreen,
                  ),
          );
        },
      ),
    );
  }
}
