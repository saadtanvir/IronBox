import 'package:cached_network_image/cached_network_image.dart';
import 'package:ironbox/src/controllers/chats_controller.dart';
import 'package:ironbox/src/widgets/chattingScreenWidget.dart';
import 'package:ironbox/src/widgets/lastMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _con.firebaseMethods.getFirebaseUser(widget.contactId),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          Map<String, dynamic> firebaseContact = snapShot.data;
          // print("name is ");
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                Get.to(
                    ChattingScreen(firebaseContact['id'],
                        firebaseContact['imgURL'], firebaseContact['username']),
                    transition: Transition.rightToLeft);
              },
              leading: UserCircularAvatar(
                  height: 60.0,
                  width: 60.0,
                  imgUrl: "${firebaseContact['imgURL']}",
                  adjustment: BoxFit.cover),
              title: Text(
                "${firebaseContact['username']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: LastMessageWidget(_con.firebaseMethods.getMessages(
                  sid: userRepo.currentUser.value.id,
                  rid: firebaseContact['id'])),
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
              leading: UserCircularAvatar(
                  height: 60.0,
                  width: 60.0,
                  imgUrl: "",
                  adjustment: BoxFit.cover),
              title: Text(""),
              subtitle: LastMessageWidget(_con.firebaseMethods.getMessages(
                  sid: userRepo.currentUser.value.id, rid: widget.contactId)),
              // trailing: Text("15:23"),
            ),
          );
        }
      },
    );
  }
}
