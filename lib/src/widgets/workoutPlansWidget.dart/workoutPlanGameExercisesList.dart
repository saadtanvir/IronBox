import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/models/workoutPlanExercise.dart';
import 'package:ironbox/src/models/workoutPlanGame.dart';
import 'package:ironbox/src/widgets/listTileWidgets/workoutPlanExerciseTile.dart';
import 'package:ironbox/src/widgets/listTileWidgets/workoutPlanGameTile.dart';
import '../../helpers/app_constants.dart' as Constants;

class WorkoutPlanGameExercisesList extends StatelessWidget {
  final List<WorkoutPlanExercise> exercisesList;
  WorkoutPlanGameExercisesList(this.exercisesList, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200 * exercisesList.length.toDouble(),
      child: GestureDetector(
        onTap: () {},
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: exercisesList.length,
          itemBuilder: (context, index) {
            return WorkoutPlanExerciseTile(exercisesList[index]);
          },
        ),
      ),
    );
  }
}
