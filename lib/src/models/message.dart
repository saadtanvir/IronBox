import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String body;
  String type;
  String senderId;
  String receiverId;
  String timeStamp;
  Timestamp serverTime;

  Message();

  Message.fromDocSnapshot(DocumentSnapshot doc) {
    try {
      body = doc.data()["body"];
      type = doc.data()["type"];
      senderId = doc.data()["senderId"];
      receiverId = doc.data()["receiverId"];
      timeStamp = doc.data()["timeStamp"];
      serverTime = doc.data()["serverTime"];
    } catch (e) {
      print("Message Model Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["body"] = this.body;
    map["senderId"] = this.senderId;
    map["receiverId"] = this.receiverId;
    map["type"] = this.type;
    map["timeStamp"] = this.timeStamp;
    map["serverTime"] = this.serverTime;
    return map;
  }
}
