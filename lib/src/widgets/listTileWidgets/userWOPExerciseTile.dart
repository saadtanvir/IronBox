import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/userWorkoutPlanExercise.dart';
import 'package:ironbox/src/models/userWorkoutPlanGame.dart';
import 'package:ironbox/src/widgets/listTileWidgets/userWorkoutPlanGameTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserWOPExerciseTile extends StatelessWidget {
  final UserWorkoutPlanExercise exercise;
  UserWOPExerciseTile(this.exercise, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      title: Text("${exercise.name}"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              exercise.reps != null
                  ? Text(
                      "${exercise.reps.toString()} reps",
                    )
                  : SizedBox(
                      width: 0.0,
                    ),
              exercise.reps != null &&
                      exercise.duration != null &&
                      exercise.duration.isNotEmpty
                  ? Text(" | ")
                  : SizedBox(
                      width: 0.0,
                    ),
              exercise.duration != null && exercise.duration.isNotEmpty
                  ? Text("${exercise.duration}min")
                  : SizedBox(
                      width: 0.0,
                    ),
            ],
          ),
          Text("${exercise.description}"),
        ],
      ),
      leading: exercise.status == 0
          ? Icon(Icons.access_time_filled_rounded)
          : Icon(
              Icons.done,
              color: Colors.green,
            ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.more_vert),
      ),
    );
  }
}
