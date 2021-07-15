import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/conversationTileWidget.dart';
import 'package:flutter/material.dart';

class ConversationsListWidget extends StatelessWidget {
  final List<User> contacts;
  ConversationsListWidget(this.contacts);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: contacts.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // open chatting screen
            // pass current and clicked user
            FocusScope.of(context).unfocus();
            // Get.to(ChattingScreen(), transition: Transition.rightToLeft);
          },
          child: ConversationTileWidget(),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
