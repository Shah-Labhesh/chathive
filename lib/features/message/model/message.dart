// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {

  String? senderId;
  String? receiverId;
  String? message;
  String? senderEmail;
  Timestamp? timestamp;
  Message({
    this.senderId,
    this.receiverId,
    this.message,
    this.senderEmail,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'senderEmail': senderEmail,
      'timestamp': timestamp,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      receiverId: map['receiverId'] != null ? map['receiverId'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      senderEmail: map['senderEmail'] != null ? map['senderEmail'] as String : null,
      timestamp: map['timestamp'] != null ? map['timestamp'] as Timestamp : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
