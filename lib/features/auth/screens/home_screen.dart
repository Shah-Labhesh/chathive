import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/features/auth/services/auth_service.dart';
import 'package:messaging_app/features/auth/model/user.dart';
import 'package:messaging_app/features/auth/widgets/user_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final service = AuthService();


  List<Users> users = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        title: Text(
          'Messaging App',
          style: theme.appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              size: theme.appBarTheme.actionsIconTheme!.size,
              color: theme.appBarTheme.actionsIconTheme!.color,
            ),
            onPressed: () {
              // sign out
              final authService =
                  Provider.of<AuthService>(context, listen: false);
              try {
                authService.signOut();
              } catch (e) {
                print(e.toString());
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<Users>>(
          stream: service.getAllUsersWithLastChats(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting && users.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (snapshot.hasData) {
              users = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data![index];
                    if (user.uid == _auth.currentUser!.uid) {
                      return const SizedBox();
                    }
                    return UserTile(
                      onTap: () {
                        // navigate to chat screen
                        Navigator.pushReplacementNamed(
                          context,
                          'message-screen',
                          arguments: {'email': user.email, 'uid': user.uid},
                        );
                      },
                      user: user,
                    );
                  },
                ),
              );
            }
            return const Text('No Data');
          },
        ),
      ),
    );
  }
}
