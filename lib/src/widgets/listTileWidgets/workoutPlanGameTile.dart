import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/models/workoutPlanGame.dart';
import '../../helpers/app_constants.dart' as Constants;

class WorkoutPlanGameTile extends StatelessWidget {
  final WorkoutPlanGame game;
  WorkoutPlanGameTile(this.game, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${game.name}"),
    );
  }
}
