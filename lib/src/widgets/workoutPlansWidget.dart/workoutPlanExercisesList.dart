import 'package:flutter/material.dart';
import 'package:ironbox/src/models/workoutPlanExercise.dart';
import 'package:ironbox/src/widgets/listTileWidgets/workoutPlanExerciseTile.dart';

class WorkoutPlanGameExercisesList extends StatelessWidget {
  final List<WorkoutPlanExercise> exercisesList;
  // final Function onGameTap;
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
