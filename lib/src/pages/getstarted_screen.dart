import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/pages/create_acc.dart';
import 'package:ironbox/src/pages/create_acc_screen.dart';
import 'package:flutter/material.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:get/get.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Constants.primaryColor,
      body: Column(
        children: [
          Container(
            height: Helper.of(context).getScreenHeight() * 0.50,
            decoration: BoxDecoration(
              color: Constants.primaryColor,
              image: DecorationImage(
                  image: AssetImage("assets/img/bgimg.png"), fit: BoxFit.fill),
            ),
            child: Center(
              child: Image(
                image: AssetImage("assets/img/logo.png"),
                height: Helper.of(context).getScreenHeight() * 0.40,
                width: Helper.of(context).getScreenWidth() * 0.50,
              ),
            ),
          ),
          Container(
            width: Helper.of(context).getScreenWidth(),
            height: Helper.of(context).getScreenHeight() * 0.40,
            color: Constants.primaryColor,
            child: Image(
              height: Helper.of(context).getScreenHeight() * 0.15,
              width: Helper.of(context).getScreenWidth() * 0.60,
              image: AssetImage("assets/img/getstarted_message.png"),
              // fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              width: Helper.of(context).getScreenWidth(),
              child: GestureDetector(
                onTap: () {
                  // Get.offAll(CreateAccountScreen());
                  Get.offAll(CreateAccount());
                },
                child: Image(
                  image: AssetImage("assets/img/btn_get_started.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
