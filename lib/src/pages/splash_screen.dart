import 'package:fitness_app/src/controllers/splash_controller.dart';
import 'package:fitness_app/src/pages/create_acc_screen.dart';
import 'package:fitness_app/src/pages/getstarted_screen.dart';
import 'package:fitness_app/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_app/src/repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController _con = Get.put(SplashController());

  void _redirectUser() {
    _con.userAuth.addListener(() {
      if (SplashController.isCallingFromSplashController) {
        print("in user auth listener");
        if (_con.userAuth.value) {
          print("Role: " + userRepo.currentUser.value.role);
          if (userRepo.currentUser.value.role == Constants.joinAsA[0]) {
            print("its a Trainee");
            print("redirecting to Trainee home page from splash screen");
            // userRepo.currentUser.re
            Get.offAllNamed('/BottomNavBarPage');
          } else if (userRepo.currentUser.value.role == Constants.joinAsA[1]) {
            print("its a trainer");
            Get.offAllNamed('/TrainerBtmNavBar');
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
    _redirectUser();
    _con.checkNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    print("in build of splash screen");
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Constants.accentColor),
        ),
      ),
    );
  }
}
