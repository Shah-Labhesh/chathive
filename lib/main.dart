import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/firebase_options.dart';
import 'package:messaging_app/features/message/screens/message_screen.dart';
import 'package:messaging_app/features/auth/services/auth_service.dart';
import 'package:messaging_app/features/auth/services/authentication_gate.dart';
import 'package:messaging_app/theme/theme_data.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthenticationGate(),
        'message-screen': (context) => const MessageScreen(),
      },
    );
  }
}
