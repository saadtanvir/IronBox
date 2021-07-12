import 'package:flutter/material.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';

class ClientTile extends StatelessWidget {
  final User client;
  const ClientTile(this.client, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        tileColor: Colors.grey[200],
        title: Text("${client.name}"),
        leading: UserCircularAvatar(
          imgUrl: "${client.avatar}",
        ));
  }
}
