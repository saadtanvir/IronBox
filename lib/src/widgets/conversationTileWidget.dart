import 'package:cached_network_image/cached_network_image.dart';
import 'package:ironbox/src/controllers/chats_controller.dart';
import 'package:ironbox/src/widgets/chattingScreenWidget.dart';
import 'package:ironbox/src/widgets/lastMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';
import '../helpers/app_constants.dart' as Constants;

class ConversationTileWidget extends StatefulWidget {
  final String contactId;
  ConversationTileWidget({this.contactId});

  @override
  _ConversationTileWidgetState createState() => _ConversationTileWidgetState();
}

class _ConversationTileWidgetState extends State<ConversationTileWidget> {
  ChatsController _con = Get.put(ChatsController());

  @override
  void initState() {
    // _con.getFirebaseUser(widget.contactId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _con.firebaseMethods.getFirebaseUser(widget.contactId),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          Map<String, dynamic> firebaseUser = snapShot.data;
          // print("name is ");
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                Get.to(
                    ChattingScreen(firebaseUser['id'], firebaseUser['imgURL'],
                        firebaseUser['username']),
                    transition: Transition.rightToLeft);
              },
              leading: UserCircularAvatar(
                  60.0, 60.0, "${firebaseUser['imgURL']}", BoxFit.cover),
              title: Text(
                "${firebaseUser['username']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: LastMessageWidget(),
              // trailing: Text("15:23"),
            ),
          );
        } else if (snapShot.hasError) {
          return Center(
            child: Text(
              Constants.check_internet_connection,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: UserCircularAvatar(60.0, 60.0, "", BoxFit.cover),
              title: Text(""),
              subtitle: LastMessageWidget(),
              // trailing: Text("15:23"),
            ),
          );
        }
      },
    );
  }
}
