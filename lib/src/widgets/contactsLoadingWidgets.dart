import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';
import '../helpers/app_constants.dart' as Constants;

class ContactsLoadingWidget extends StatelessWidget {
  const ContactsLoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.of(context).getScreenHeight() * 0.15,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 4.0, left: 4.0),
            child: Container(
              width: 80.0,
              child: Column(
                children: [
                  UserCircularAvatar(
                      height: 60.0,
                      width: 60.0,
                      imgUrl: "contact/avatar",
                      adjustment: BoxFit.cover),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
