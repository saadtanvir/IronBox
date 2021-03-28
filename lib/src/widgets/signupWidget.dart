import 'package:fitness_app/src/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.accentColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Get.to(Signup());
              },
              child: Image(
                image: AssetImage("assets/img/btn_sign_up_email2.png"),
              )),
          TextButton(
              onPressed: () {},
              child: Image(
                image: AssetImage("assets/img/btn_sign_up_phone.png"),
              )),
        ],
      ),
    );
  }
}
