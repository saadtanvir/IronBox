import 'package:fitness_app/src/controllers/splash_controller.dart';
import 'package:fitness_app/src/pages/create_acc_screen.dart';
import 'package:fitness_app/src/pages/getstarted_screen.dart';
import 'package:fitness_app/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // check if user is logged in
  // if yes ? redirect to home screen
  // if no ? redirect to getstarted screen

  SplashController _con = Get.put(SplashController());

  void _redirectUser() {
    print("redirecting");
    _con.userAuth.addListener(() {
      Get.offAllNamed('/BottomNavBarPage');
      // if (_con.userAuth.value) {
      //   Get.offAll(Home());
      // } else {
      //   Get.offAll(GetStartedScreen());
      // }
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
    print("in build");
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
