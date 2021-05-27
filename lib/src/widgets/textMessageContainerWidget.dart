import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/message.dart';
import 'package:flutter/material.dart';
import '../repositories/user_repo.dart' as userRepo;

class MessageContainer extends StatelessWidget {
  final Message message;
  final String currentUserId = userRepo.currentUser.value.id;
  MessageContainer(this.message);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: message.senderId == currentUserId
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: Helper.of(context).getScreenWidth() * 0.70),
            decoration: BoxDecoration(
              color: message.senderId == currentUserId
                  ? Theme.of(context).primaryColor.withOpacity(0.9)
                  : Colors.white,
              borderRadius: message.senderId == currentUserId
                  ? Helper.senderMessageBoxRadius()
                  : Helper.receiverMessageBoxRadius(),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, right: 15.0, bottom: 10.0, left: 10.0),
              child: Text(
                "${message.body}",
                style: TextStyle(
                  color: message.senderId == currentUserId
                      ? Colors.white
                      : Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "${Helper.getMessageTime(message.serverTime.toDate())}",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
