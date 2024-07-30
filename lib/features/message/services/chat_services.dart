import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:messaging_app/features/message/model/message.dart';
import 'package:messaging_app/utils/toast_utils.dart';

class ChatServices extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SEND MESSAGES
  Future sendMessage(
      {required String message,
      required String receiverId,
      required BuildContext ctx}) async {
    try {
      User? user = _auth.currentUser;
      String senderId = user!.uid;
      String senderEmail = user.email!;
      Timestamp timestamp = Timestamp.now();

      Message _message = Message(
        senderId: senderId,
        receiverId: receiverId,
        message: message,
        senderEmail: senderEmail,
        timestamp: timestamp,
      );

      List<String> members = [senderId, receiverId];
      members.sort();
      String roomId = members.join('_');
      await _firestore
          .collection('chat_rooms')
          .doc(roomId)
          .collection('messages')
          .add(_message.toMap());
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          ToastUtils.show(ctx, 'The email address is not valid.',
              isSuccess: false);
          break;
        case 'user-disabled':
          ToastUtils.show(ctx, 'The user account has been disabled.',
              isSuccess: false);
          break;
        case 'user-not-found':
          ToastUtils.show(ctx, 'The user account does not exist.',
              isSuccess: false);
          break;
        case 'wrong-password':
          ToastUtils.show(ctx, 'The password is invalid.', isSuccess: false);
          break;
        case 'network-request-failed':
          ToastUtils.show(ctx, 'Please check your internet connection.',
              isSuccess: false);
          break;
        case 'too-many-requests':
          ToastUtils.show(ctx, 'Too many requests. Try again later.',
              isSuccess: false);
          break;
        default:
          ToastUtils.show(ctx, 'Something went wrong. Try again later.',
              isSuccess: false);
      }
    } catch (e) {
      ToastUtils.show(ctx, 'Something went wrong. Try again later.',
          isSuccess: false);
    }
  }

  // GET MESSAGES
  Stream<QuerySnapshot> getMessages({required String receiverId}) {
    User? user = _auth.currentUser;
    String senderId = user!.uid;
    List<String> members = [senderId, receiverId];
    members.sort();
    String roomId = members.join('_');
    try {
      return _firestore
          .collection('chat_rooms')
          .doc(roomId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots();
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return Stream.error('The email address is not valid.');

        case 'user-disabled':
          return Stream.error('The user account has been disabled');

        case 'user-not-found':
          return Stream.error('The user account does not exist');

        case 'wrong-password':
          return Stream.error('The password is invalid.');
        case 'network-request-failed':
          return Stream.error('Please check your internet connection.');
        case 'too-many-requests':
          return Stream.error('Too many requests. Try again later.');
        default:
          return Stream.error('Something went wrong. Try again later.');
      }
    } catch (e) {
      return Stream.error('Something went wrong. Try again later.');
    }
  }
}
