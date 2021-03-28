import 'package:fitness_app/src/helpers/app_config.dart';
import 'package:fitness_app/src/pages/btm_nav_bar_pages.dart';
import 'package:fitness_app/src/pages/splash_screen.dart';
import 'package:fitness_app/src/repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // getUser();
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTheme theme;

  @override
  void initState() {
    // TODO: implement initState
    theme = new AppTheme();
    userRepo.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getAppTheme(),
      initialRoute: "/Splash",
      getPages: [
        GetPage(
            name: "/Splash",
            page: () {
              return SplashScreen();
            }),
        GetPage(
            name: "/BottomNavBarPage",
            page: () {
              return BottomNavigationBarPages();
            })
        // GetPage(name: "/GetStarted", page: (){return GetStartedScreen();})
      ],
    );
  }
}
