import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/workoutPlanExercise.dart';
import 'package:ironbox/src/widgets/dialogs/playWPExerciseVideo.dart';

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
          const SizedBox(
            width: 5.0,
          ),
          exercise.reps.toString().isNotEmpty
              ? const Text("|")
              : const SizedBox(
                  height: 0.0,
                  width: 0.0,
                ),
          const SizedBox(
            width: 5.0,
          ),
          exercise.reps.toString().isNotEmpty
              ? Text("${exercise.reps} reps")
              : const SizedBox(
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
              icon: const Icon(Icons.play_circle),
            )
          : const SizedBox(
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
