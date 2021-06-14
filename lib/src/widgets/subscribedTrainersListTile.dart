import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/subscriptions.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';

class SubscribedTrainerListTile extends StatelessWidget {
  final Subscription subscription;
  const SubscribedTrainerListTile(this.subscription, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserCircularAvatar(
          85.0, 65.0, subscription.trainers.avatar, BoxFit.cover),
      title: Text("${subscription.trainers.name}"),
      subtitle: Text("${subscription.trainers.specializesIn}"),
      trailing: Container(
        width: 100.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              "\$${subscription.trainers.price} ",
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
                Text(
                    "${subscription.trainers.userRating.rating.toStringAsFixed(1)}"),
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
