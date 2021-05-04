import 'package:fitness_app/src/pages/getstarted_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:fitness_app/src/repositories/user_repo.dart' as userRepo;

class SplashController extends GetxController {
  ValueNotifier<bool> userAuth = new ValueNotifier(false);
  SplashController() {
    print("in splash controller init");
    userRepo.currentUser.addListener(() {
      print("in current user listener splash controller");
      if (userRepo.currentUser.value.userToken != null) {
        print("current user is not null");
        userAuth.value = true;
        // userAuth.notifyListeners();
      } else {
        print("current user is null");
        userAuth.value = false;
        userAuth.notifyListeners();
      }
    });
  }

  @override
  void onInit() {
    print("inside init of splash controller");

    // print("in splash controller init");
    // userRepo.currentUser.addListener(() {
    //   print("in current user listener splash controller");
    //   if (userRepo.currentUser.value.userToken != null) {
    //     print("current user is not null");
    //     userAuth.value = true;
    //     userAuth.notifyListeners();
    //   } else {
    //     print("current user is null");
    //     userAuth.value = false;
    //     userAuth.notifyListeners();
    //   }
    // });
    // super.onInit();
  }
}
