import 'package:ironbox/src/pages/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageIconWidget extends StatefulWidget {
  @override
  _MessageIconWidgetState createState() => _MessageIconWidgetState();
}

class _MessageIconWidgetState extends State<MessageIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  // open messages screen
                  Get.to(Messages());
                },
                child: Icon(
                  Icons.message_outlined,
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 10.0,
          //   right: 2.0,
          //   child: CircleAvatar(
          //     backgroundColor: Theme.of(context).primaryColor,
          //     radius: 8.0,
          //     child: Text(
          //       "2",
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 10.0,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
