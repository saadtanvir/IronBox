import 'package:flutter/material.dart';
import '../models/subscriptions.dart';
import '../widgets/userCircularAatar.dart';

class SubscribedTrainerListTile extends StatelessWidget {
  final Subscription subscription;
  const SubscribedTrainerListTile(this.subscription, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserCircularAvatar(
          height: 85.0,
          width: 65.0,
          imgUrl: subscription.trainers.avatar,
          adjustment: BoxFit.cover),
      title: Text("${subscription.trainers.name}"),
      subtitle: Text("${subscription.trainers.specializesIn}"),
      trailing: Container(
        width: 100.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "\$${subscription.trainers.price} ",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    "${subscription.trainers.userRating.rating.toStringAsFixed(1)}"),
                const Icon(
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
