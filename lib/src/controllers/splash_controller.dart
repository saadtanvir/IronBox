import 'package:fitness_app/src/pages/getstarted_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fitness_app/src/repositories/user_repo.dart' as userRepo;

class SplashController extends GetxController {
  ValueNotifier<bool> userAuth = new ValueNotifier(false);
  static bool isCallingFromSplashController;
  SplashController() {
    isCallingFromSplashController = true;
    print("in splash controller init");
    userRepo.currentUser.addListener(() {
      print("in current user listener splash controller");
      if (userRepo.currentUser.value.userToken != null &&
          isCallingFromSplashController) {
        print("current user is not null");
        userAuth.value = true;
        // userAuth.notifyListeners();
      } else if (isCallingFromSplashController) {
        print("current user is null");
        userAuth.value = false;
        userAuth.notifyListeners();
      }
    });
  }

  @override
  void onInit() {
    print("inside init of splash controller");
  }

  Future<void> checkNotificationPermission() async {
    Permission notificationPermission = Permission.notification;
    PermissionStatus status = await notificationPermission.status;
    if (status.isGranted) {
      print("Permission is granted");
    } else {
      status = await notificationPermission.request();
      print(status.isGranted);
    }
  }
}
