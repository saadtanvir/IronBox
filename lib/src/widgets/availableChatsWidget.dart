import 'package:flutter/material.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';

class AvailableUserChatsWidget extends StatelessWidget {
  final User contact;
  AvailableUserChatsWidget(this.contact);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, left: 4.0),
      child: Container(
        width: 80.0,
        child: Column(
          children: [
            UserCircularAvatar(
                height: 60.0,
                width: 60.0,
                imgUrl: contact.avatar,
                adjustment: BoxFit.cover),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              "${contact.name}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
