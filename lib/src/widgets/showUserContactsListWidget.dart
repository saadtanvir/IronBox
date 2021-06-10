import 'package:flutter/material.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/availableChatsWidget.dart';
import 'package:ironbox/src/widgets/chattingScreenWidget.dart';

class UserContactsListWidget extends StatelessWidget {
  final List<User> contacts;
  const UserContactsListWidget(this.contacts, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.of(context).getScreenHeight() * 0.12,
      child: ListView.builder(
        itemCount: contacts.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Get.to(
                  ChattingScreen(contacts[index].id, contacts[index].avatar,
                      contacts[index].userName),
                  transition: Transition.rightToLeft);
            },
            child: AvailableUserChatsWidget(contacts[index]),
          );
        },
      ),
    );
  }
}
