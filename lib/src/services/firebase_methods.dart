import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ironbox/src/models/message.dart';
import 'package:ironbox/src/models/userContact.dart';
import '../helpers/app_constants.dart' as Constants;

class FirebaseMethods {
  FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;
  CollectionReference _messagesCollection;
  CollectionReference _usersCollection;
  DateFormat _dateFormatter;

  FirebaseMethods() {
    _messagesCollection = _firebaseFirestoreInstance.collection("messages");
    _usersCollection = _firebaseFirestoreInstance.collection("users");
    _dateFormatter = DateFormat(Constants.dateStringFormat);
  }

  // add user's username and img url to firebase collection 'users'
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

    _addToContactList(
        senderId: message.senderId, receiverId: message.receiverId);

    await _messagesCollection
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(messageMap);
  }

  DocumentReference _getContactDocument(String userId, String contactId) {
    // check whether user has a contact or not, if yes then send the doc snapshot
    return _usersCollection
        .doc(userId)
        .collection(Constants.contact)
        .doc(contactId);
  }

  Future<void> _addToContactList(
      {@required String senderId, @required String receiverId}) async {
    // First make a contact in sender's collection
    // then in receiver collection
    await _addToSenderContacts(userId: senderId, contactId: receiverId);
    await _addToReceiverContacts(userId: receiverId, contactId: senderId);
  }

  Future<void> _addToSenderContacts({String userId, String contactId}) async {
    DocumentSnapshot senderContact =
        await _getContactDocument(userId, contactId).get();

    if (!senderContact.exists) {
      // contact does not exist already
      // create a new contact
      UserContact senderContact = new UserContact();
      senderContact.contactId = contactId;
      senderContact.createdAt = _dateFormatter.format(DateTime.now());

      await _getContactDocument(userId, contactId).set(senderContact.toMap());
    }
  }

  Future<void> _addToReceiverContacts({String userId, String contactId}) async {
    DocumentSnapshot senderContact =
        await _getContactDocument(userId, contactId).get();

    if (!senderContact.exists) {
      // contact does not exist already
      // create a new contact
      UserContact senderContact = new UserContact();
      senderContact.contactId = contactId;
      senderContact.createdAt = _dateFormatter.format(DateTime.now());

      await _getContactDocument(userId, contactId).set(senderContact.toMap());
    }
  }

  Future<Map<String, dynamic>> getFirebaseUser(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await _usersCollection.doc(uid).get();
      print("fetching firebase user");
      print(documentSnapshot.data());
      return documentSnapshot.data();
    } catch (e) {
      print("FirebaseMethods Class Error: $e");
    }
  }

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

  Stream<QuerySnapshot> fetchContacts(String uid) {
    return _usersCollection.doc(uid).collection(Constants.contact).snapshots();
  }
}
