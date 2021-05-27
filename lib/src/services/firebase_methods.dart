import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ironbox/src/models/message.dart';

class FirebaseMethods {
  FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;
  CollectionReference _messagesCollection;
  CollectionReference _usersCollection;

  FirebaseMethods() {
    _messagesCollection = _firebaseFirestoreInstance.collection("messages");
    _usersCollection = _firebaseFirestoreInstance.collection("users");
  }

  // add user's username and img url to firebase collection users
  // under doc id = user id
  Future<void> addUserToFirebase(
      {String uid, String username, String imgURL}) async {
    print("adding user to firebase");
    Map<String, dynamic> userData = {
      "id": uid,
      "username": username.toString(),
      "imgURL": imgURL.toString()
    };
    await _usersCollection.doc(uid).set(userData).catchError((e) {
      print("Firebase Methods Error: ${e.toString()}");
    }).whenComplete(() {
      print("firebase user adding process completed");
    });
  }

  // add message to messages collection
  Future<void> addMessageToCollection(Message message) async {
    var messageMap = message.toMap();

    await _messagesCollection
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(messageMap);

    await _messagesCollection
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(messageMap);
  }

  Future<void> addToContactList() {}

  Stream<List<Message>> getMessages({String sid, String rid}) {
    return _messagesCollection
        .doc(sid)
        .collection(rid)
        .orderBy("serverTime", descending: false)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<Message> messages = List<Message>();
      snapshot.docs.forEach((element) {
        // print(element.data()['body']);
        messages.add(Message.fromDocSnapshot(element));
      });
      return messages;
    });
  }
}
