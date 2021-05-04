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
      // Get.offAllNamed('/BottomNavBarPage');

      print("in user auth listener");
      if (_con.userAuth.value) {
        // check user role and redirect accordingly
        // Get.offAll(Home());
        if (userRepo.currentUser.value.role == Constants.joinAsA[0]) {
          // its a trainee
          print("redirecting to Trainee home page from splash screen");
          Get.offAllNamed('/BottomNavBarPage');
        } else if (userRepo.currentUser.value.role == Constants.joinAsA[1]) {
          // its a trainer
        }
      } else {
        print("redirecting to get started screen from splash screen");
        Get.offAll(GetStartedScreen());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _redirectUser();
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
