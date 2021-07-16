import 'package:flutter/material.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';

class TrainerListTile extends StatelessWidget {
  final User trainer;
  TrainerListTile(this.trainer);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserCircularAvatar(
          height: 85.0,
          width: 65.0,
          imgUrl: trainer.avatar,
          adjustment: BoxFit.cover),
      title: Text("${trainer.name}"),
      subtitle: Text("${trainer.specializesIn}"),
      trailing: Container(
        width: 100.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "\$${trainer.price} ",
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
                Text("${trainer.userRating.rating.toStringAsFixed(1)}"),
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
