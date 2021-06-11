import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';

class TrainerListTile extends StatelessWidget {
  final User trainer;
  TrainerListTile(this.trainer);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserCircularAvatar(85.0, 65.0, trainer.avatar, BoxFit.cover),
      title: Text("${trainer.name}"),
      subtitle: Text("${trainer.specializesIn}"),
      trailing: Container(
        width: 100.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              "\$${trainer.price} ",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("${trainer.userRating.rating.toStringAsFixed(1)}"),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 20.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
