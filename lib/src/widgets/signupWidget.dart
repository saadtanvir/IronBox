import 'package:ironbox/src/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;

// File no longer in use
class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.accentColor,
      child: TextButton(
        onPressed: () async {
          print("still in widget");
        },
        child: Text(
          Constants.signup_with_email,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 50.0)),
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).scaffoldBackgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ),
      ),
    );
  }
}
