import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messaging_app/features/message/services/chat_services.dart';
import 'package:messaging_app/features/message/widgets/chat_app_bar.dart';
import 'package:messaging_app/features/message/widgets/chat_message.dart';
import 'package:messaging_app/features/message/widgets/message_field.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _controller = ScrollController();
  final ChatServices service = ChatServices();

  bool activeStatus = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String uid = '';
  String email = '';

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

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args == null) {
      Navigator.pop(context);
    } else {
      uid = args['uid'];
      email = args['email'];
    }
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

        Navigator.pushReplacementNamed(context, '/');
      },
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Container(
           
            child: Column(
              children: [
                ChatAppBar(
                  userName: email.toString().split('@').first,
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: service.getMessages(receiverId: uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: Text('no messages'),
                          );
                        }
                        // return ListView.builder(
                        //   controller: _controller,
                        //   reverse: true,
                        //   itemCount: snapshot.data!.data()!.length,
                        //   itemBuilder: (context, index) {
                        //    final message = snapshot.data!.data()!['message'];
                        //     return ChatMessage(
                        //       text: message,
                        //       isUser: _auth.currentUser!.email == args,
                        //       time: DateTime.now().toString(),
                        //     );
                        //   },
                        // );
                        return ListView.builder(
                          controller: _controller,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final message = snapshot.data!.docs[index];
                            var time = message['timestamp'];
                            return ChatMessage(
                              text: message['message'],
                              isUser:
                                  _auth.currentUser!.uid == message['senderId'],
                              time: timestampToDateTime(
                                  time.seconds, time.nanoseconds),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No messages'),
                        );
                      }
                    },
                  ),
                ),
                CustomMessageInput(
                  controller: _textEditingController,
                  onSendPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    String message = _textEditingController.text.trim();
    if (message.isNotEmpty) {
      ChatServices().sendMessage(message: message, receiverId: uid, ctx: context);
      _textEditingController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
