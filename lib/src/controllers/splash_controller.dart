import 'package:fitness_app/src/pages/getstarted_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:fitness_app/src/repositories/user_repo.dart' as userRepo;

class SplashController extends GetxController {
  ValueNotifier<bool> userAuth = new ValueNotifier(false);
  SplashController() {}

  @override
  void onInit() {
    // TODO: implement onInit

    userRepo.currentUser.addListener(() {
      if (userRepo.currentUser.value.auth != null &&
          userRepo.currentUser.value.auth == true) {
        print("current user is not null");
        print(userRepo.currentUser.value.auth);
        userAuth.value = true;
      } else {
        userAuth.value = false;
      }
      userAuth.notifyListeners();
    });

    // userAuth.value = userRepo.currentUser.value.auth != null ? true : false;
    // userAuth.notifyListeners();
    super.onInit();
  }
}
