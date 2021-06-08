import 'package:ironbox/src/models/message.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/services/firebase_methods.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;

class ChatsController extends GetxController {
  FirebaseMethods firebaseMethods = new FirebaseMethods();
  User user = new User();
  List<User> contacts = List<User>();
  Message message = new Message();
  var messages = List<Message>().obs;
  List<Message> get messagesList => messages;
  var doneFetchingContacts = false.obs;
  ChatsController() {}

  Future<void> sendMessage() async {
    await firebaseMethods.addMessageToCollection(message);
  }

  void getContacts(String uid) async {
    doneFetchingContacts.value = false;
    contacts.clear();
    final Stream<User> stream = await userRepo.getUserContacts(uid);

    stream.listen((User _contact) {
      print(_contact.name);
      contacts.add(_contact);
    }, onError: (e) {
      print("Chats controller error: $e");
    }, onDone: () {
      doneFetchingContacts.value = true;
    });
  }

  void getUserDetails(String id) async {
    user = await userRepo.getUserById(id);
  }

  void getFirebaseUser(String uid) async {
    // print(firebaseUser);
  }
}
