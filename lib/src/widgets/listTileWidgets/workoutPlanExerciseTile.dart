import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/models/workoutPlanExercise.dart';
import 'package:ironbox/src/models/workoutPlanGame.dart';
import 'package:ironbox/src/widgets/dialogs/playWPExerciseVideo.dart';
import 'package:ironbox/src/widgets/playYoutubeVideoWidget.dart';
import '../../helpers/app_constants.dart' as Constants;

class WorkoutPlanExerciseTile extends StatelessWidget {
  final WorkoutPlanExercise exercise;
  WorkoutPlanExerciseTile(this.exercise, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      // isThreeLine: true,
      title: Text("${exercise.name}"),
      subtitle: Row(
        children: [
          Text("${exercise.duration}min"),
          SizedBox(
            width: 5.0,
          ),
          exercise.reps.toString().isNotEmpty
              ? Text("|")
              : SizedBox(
                  height: 0.0,
                  width: 0.0,
                ),
          SizedBox(
            width: 5.0,
          ),
          exercise.reps.toString().isNotEmpty
              ? Text("${exercise.reps} reps")
              : SizedBox(
                  height: 0.0,
                  width: 0.0,
                ),
        ],
      ),
      trailing: exercise.videoUrl.isNotEmpty
          ? IconButton(
              onPressed: () {
                // play youtube video on popup
                Get.dialog(
                    PlayWorkoutPlanExerciseVideoDialog(exercise.videoUrl));
              },
              icon: Icon(Icons.play_circle),
            )
          : SizedBox(
              height: 0.0,
              width: 0.0,
            ),
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "${exercise.description}",
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: PlayYoutubeVideoWidget(exercise.videoUrl),
        // ),
      ],
    );
  }
}
