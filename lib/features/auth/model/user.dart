// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:messaging_app/features/message/model/message.dart';

class Users {

  String? uid;
  String? email;
  Message? lastMessage;
  Users({
    this.uid,
    this.email,
    this.lastMessage,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'lastMessage': lastMessage?.toMap(),
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      uid: map['uid'] != null ? map['uid'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      lastMessage: map['lastMessage'] != null ? Message.fromMap(map['lastMessage'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source) as Map<String, dynamic>);
}
