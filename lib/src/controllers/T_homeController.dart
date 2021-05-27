import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/repositories/message_repo.dart' as messageRepo;
import 'package:get/get.dart';

class TrainerHomeController extends GetxController {
  var clients = List<User>().obs;
  var doneFetchingClients = false.obs;
  TrainerHomeController() {}

  void getClientsList(String uid) async {
    print("fetching user contacts");
    doneFetchingClients.value = false;
    final Stream<User> stream = await messageRepo.getUserContacts(uid);

    stream.listen(
      (User _user) {
        clients.add(_user);
      },
      onError: (e) {
        print("Message Controller Error: $e");
      },
      onDone: () {
        print("done fetching contacts");
        doneFetchingClients.value = true;
      },
    );
  }
}
