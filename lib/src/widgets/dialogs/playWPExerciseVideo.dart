import 'package:flutter/material.dart';
import '../../widgets/playYoutubeVideoWidget.dart';
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
