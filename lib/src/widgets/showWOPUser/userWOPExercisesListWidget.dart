import 'package:ironbox/src/helpers/helper.dart';
import '../../models/userWorkoutPlanExercise.dart';
import '../../widgets/listTileWidgets/userWOPExerciseTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserWOPExercisesListWidget extends StatelessWidget {
  final List<UserWorkoutPlanExercise> exercisesList;
  // final Function onExerciseTap;
  final Function addToLogs;
  final Function markAsCompleted;
  final Function playVideo;
  UserWOPExercisesListWidget(
      this.exercisesList, this.addToLogs, this.markAsCompleted, this.playVideo,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0 * exercisesList.length.toDouble(),
      width: Helper.of(context).getScreenWidth(),
      // color: Colors.amber,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: exercisesList.length,
        itemBuilder: (context, index) {
          // print("returing card widget");
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                // onExerciseTap(exercisesList[index]);
              },
              child: UserWOPExerciseTile(
                exercisesList[index],
                addToLogs: addToLogs,
                markAsCompleted: markAsCompleted,
                playVideo: playVideo,
              ),
            ),
          );
        },
      ),
    );
  }
}
