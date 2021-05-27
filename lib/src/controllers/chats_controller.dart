import 'package:ironbox/src/models/message.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/services/firebase_methods.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  FirebaseMethods firebaseMethods = new FirebaseMethods();
  List<User> users = List<User>();
  Message message = new Message();
  var messages = List<Message>().obs;
  List<Message> get messagesList => messages;
  ChatsController() {}

  Future<void> sendMessage() async {
    await firebaseMethods.addMessageToCollection(message);
  }
}
