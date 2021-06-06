import 'package:flutter/material.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/availableChatsWidget.dart';
import 'package:ironbox/src/widgets/chattingScreenWidget.dart';

class UserContactsListWidget extends StatefulWidget {
  final List<User> contacts;
  const UserContactsListWidget(this.contacts, {Key key}) : super(key: key);

  @override
  _UserContactsListWidgetState createState() => _UserContactsListWidgetState();
}

class _UserContactsListWidgetState extends State<UserContactsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.of(context).getScreenHeight() * 0.15,
      child: ListView.builder(
        itemCount: widget.contacts.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Get.to(
                  ChattingScreen(
                      widget.contacts[index].id,
                      widget.contacts[index].avatar,
                      widget.contacts[index].userName),
                  transition: Transition.rightToLeft);
            },
            child: AvailableUserChatsWidget(widget.contacts[index]),
          );
        },
      ),
    );
  }
}
