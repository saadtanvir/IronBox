import 'package:get/get.dart';
import 'package:ironbox/src/models/user.dart';
import '../repositories/user_repo.dart' as userRepo;

class DietSectionController extends GetxController {
  var dietitiansList = <User>[].obs;

  // progress variables
  var doneFetchingDietitians = false.obs;

  void getDietitians() async {
    dietitiansList.clear();
    doneFetchingDietitians.value = false;

    Stream<User> stream = await userRepo.fetchSpecialisedTrainers("2");
    stream.listen((User u) {
      dietitiansList.add(u);
    }, onError: (e) {
      print("Diet section controller error: $e");
    }, onDone: () {
      doneFetchingDietitians.value = true;
    });
  }
}
