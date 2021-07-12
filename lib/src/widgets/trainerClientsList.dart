import 'package:flutter/material.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/availableChatsWidget.dart';
import 'package:ironbox/src/widgets/chattingScreenWidget.dart';
import 'package:ironbox/src/widgets/listTileWidgets/clientTile.dart';

class TrainerClientsList extends StatelessWidget {
  List<User> clients;
  final Function onClientTap;
  TrainerClientsList(this.clients, this.onClientTap, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150 * clients.length.toDouble(),
      child: ListView.builder(
        itemCount: clients.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                onClientTap(clients[index]);
              },
              child: ClientTile(clients[index]),
            ),
          );
        },
      ),
    );
  }
}
