import 'package:flutter/foundation.dart';
import 'package:ironbox/src/controllers/splash_controller.dart';
import 'package:ironbox/src/pages/create_acc_screen.dart';
import 'package:ironbox/src/pages/getstarted_screen.dart';
import 'package:ironbox/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController _con = Get.put(SplashController());

  Future<void> _redirectUser(bool testArgument) async {
    _con.userAuth.addListener(() {
      if (SplashController.isCallingFromSplashController) {
        print("in user auth listener");
        if (_con.userAuth.value) {
          print("Role: " + userRepo.currentUser.value.role);
          if (userRepo.currentUser.value.role.capitalizeFirst ==
              Constants.joinAsA[0]) {
            print("its a Trainee");
            print("redirecting to Trainee home page from splash screen");
            // userRepo.currentUser.re
            Get.offAllNamed('/BottomNavBarPage');
          } else if (userRepo.currentUser.value.role.capitalizeFirst ==
              Constants.joinAsA[1]) {
            print("its a trainer");
            if (userRepo.currentUser.value.accountStatus == 1) {
              Get.offAllNamed('/TrainerBtmNavBar');
            } else {
              print("Trainer not approved yet");
              Get.offAllNamed('/TrainerUnApprovedAccount');
            }
          }
        } else {
          print("redirecting to get started screen from splash screen");
          Get.offAll(GetStartedScreen());
        }
      }
      SplashController.isCallingFromSplashController = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _redirectUser(true);
    // compute(_redirectUser, true);
    _con.checkNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    print("in build of splash screen");
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: const Center(
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Constants.accentColor),
        ),
      ),
    );
  }
}
