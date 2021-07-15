import '../../helpers/helper.dart';
import '../../models/userWorkoutPlanGame.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class UserWOPGameTileWidget extends StatelessWidget {
  final UserWorkoutPlanGame game;
  UserWOPGameTileWidget(this.game, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${game.name}"),
      subtitle: Text("Sets: ${game.sets}"),
      leading: CircularPercentIndicator(
        percent: game.progress / 100,
        radius: 50.0,
        lineWidth: 5.0,
        backgroundColor: Colors.grey[200],
        progressColor: Colors.green,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${game.progress.toStringAsFixed(1)} %",
              overflow: TextOverflow.ellipsis,
              style: Helper.of(context)
                  .textStyle(size: 10.0, color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.more_vert),
      ),
      tileColor: Colors.grey[300],
    );
  }
}
