import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/models/workoutPlanExercise.dart';
import 'package:ironbox/src/models/workoutPlanGame.dart';
import 'package:ironbox/src/widgets/playYoutubeVideoWidget.dart';
import '../../helpers/app_constants.dart' as Constants;

class PlayWorkoutPlanExerciseVideoDialog extends StatelessWidget {
  final String videoUrl;
  PlayWorkoutPlanExerciseVideoDialog(this.videoUrl, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 195.0,
          child: PlayYoutubeVideoWidget(
            videoUrl,
          ),
        ),
      ),
    );
  }
}
