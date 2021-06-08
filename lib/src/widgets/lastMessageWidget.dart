import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/message.dart';

class LastMessageWidget extends StatelessWidget {
  final stream;
  LastMessageWidget(this.stream);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: stream,
      builder: (context, messages) {
        if (messages.hasData) {
          if (messages.data.isNotEmpty) {
            var lastMessage = messages.data.last;

            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    lastMessage.body,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    lastMessage.timeStamp,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            );
          } else {
            return Text("");
          }
        } else {
          return Text("...");
        }
      },
    );
  }
}
