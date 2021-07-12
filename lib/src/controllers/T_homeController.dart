import 'package:ironbox/src/models/category.dart';
import 'package:ironbox/src/models/user.dart';
import '../repositories/user_repo.dart' as userRepo;
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/category_repo.dart' as categoryRepo;

class TrainerHomeController extends GetxController {
  var clients = List<User>().obs;
  var categories = List<Category>().obs;
  var doneFetchingClients = false.obs;
  TrainerHomeController() {}

  void getClientsList(String uid) async {
    print("fetching user contacts");
    doneFetchingClients.value = false;
    clients.clear();
    final Stream<User> stream = await userRepo.getUserContacts(uid);

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
