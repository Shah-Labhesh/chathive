import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/features/message/model/message.dart';
import 'package:messaging_app/features/auth/model/user.dart';
import 'package:messaging_app/utils/toast_utils.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign in wih email and password
  Future signInWithEmailAndPassword(
      String email, String password, BuildContext ctx) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      _firestore.collection('users').doc(user!.uid).set({
        'email': user.email,
        'uid': user.uid,
      }, SetOptions(merge: true));
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
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
        case 'invalid-credential':
          ToastUtils.show(ctx, 'Invalid credentials. Try again later.',
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

  // register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, BuildContext ctx) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      _firestore.collection('users').doc(user!.uid).set({
        'email': user.email,
        'uid': user.uid,
      });
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          ToastUtils.show(ctx, 'The email address is already in use.',
              isSuccess: false);
          break;
        case 'invalid-email':
          ToastUtils.show(ctx, 'The email address is not valid.',
              isSuccess: false);
          break;
        case 'operation-not-allowed':
          ToastUtils.show(ctx, 'Email & Password accounts are not enabled.',
              isSuccess: false);
          break;
        case 'weak-password':
          ToastUtils.show(ctx, 'The password is too weak.', isSuccess: false);
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

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print('An error occurred: $e');
    }
  }

  // GET ALL USERS EXCEPT ME AND ALSO WITH LAST CHATS WITH ME
  Stream<List<Users>> getAllUsersWithLastChats() async* {
    try {
      String uid = _auth.currentUser!.uid;

      // Get all users except the current user
      var usersSnapshots = _firestore
          .collection('users')
          .where('uid', isNotEqualTo: uid)
          .snapshots();

      await for (var usersSnapshot in usersSnapshots) {
        List<Users> usersWithLastChats = [];

        for (var userDoc in usersSnapshot.docs) {
          var userData = userDoc.data();
          var userId = userData['uid'];
          List<String> members = [uid, userId];
          members.sort();
          String roomId = members.join('_');
          // Get the last chat with the current user
          var chatSnapshot = await _firestore
              .collection('chat_rooms')
              .doc(roomId)
              .collection('messages')
              .orderBy('timestamp', descending: true)
              .limit(1)
              .get();
          print(chatSnapshot.docs);
          var lastChat = chatSnapshot.docs.isNotEmpty
              ? chatSnapshot.docs.first.data()
              : null;

          usersWithLastChats.add(Users(
              uid: userId,
              email: userData['email'],
              lastMessage: lastChat == null
                  ? null
                  : Message(
                      message: lastChat['message'],
                      receiverId: lastChat['receiverId'],
                      senderId: lastChat['senderId'],
                      senderEmail: lastChat['senderEmail'],
                      timestamp: lastChat['timestamp'],
                    )));
        }

        // SORT BY LAST MESSAGE timestamp
        // Sort users by the timestamp of their last message
        usersWithLastChats.sort((a, b) {
          if (a.lastMessage == null && b.lastMessage == null) {
            return 0;
          } else if (a.lastMessage == null) {
            return 1;
          } else if (b.lastMessage == null) {
            return -1;
          } else {
            var bTime = Timestamp(b.lastMessage!.timestamp!.seconds,
                b.lastMessage!.timestamp!.nanoseconds);
            var aTime = Timestamp(a.lastMessage!.timestamp!.seconds,
                a.lastMessage!.timestamp!.nanoseconds);
            return bTime.compareTo(aTime);
          }
        });

        yield usersWithLastChats;
      }
    } 
    
    catch (e) {
      yield [];
    }
  }
}
