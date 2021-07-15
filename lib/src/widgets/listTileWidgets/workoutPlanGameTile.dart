import 'package:flutter/material.dart';
import 'package:ironbox/src/models/workoutPlanGame.dart';

class WorkoutPlanGameTile extends StatelessWidget {
  final WorkoutPlanGame game;
  WorkoutPlanGameTile(this.game, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey[300],
      title: Text("${game.name}"),
      subtitle: Text(
        "${game.sets} sets",
      ),
    );
  }
}
