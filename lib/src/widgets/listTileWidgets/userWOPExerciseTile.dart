import 'package:ironbox/src/models/userWorkoutPlanExercise.dart';
import 'package:flutter/material.dart';

class UserWOPExerciseTile extends StatelessWidget {
  final UserWorkoutPlanExercise exercise;
  final Function addToLogs;
  final Function markAsCompleted;
  final Function playVideo;
  List<PopupMenuItem> menuItems;
  UserWOPExerciseTile(this.exercise,
      {Key key, this.addToLogs, this.markAsCompleted, this.playVideo})
      : super(key: key) {
    this.menuItems = [
      exercise.videoUrl != null && exercise.videoUrl.isNotEmpty
          ? PopupMenuItem(
              value: 0,
              child: Text(
                "Play video",
              ),
            )
          : null,
      PopupMenuItem(
        value: 1,
        child: Text(
          "Add to logs",
        ),
      ),
      exercise.status != 1
          ? PopupMenuItem(
              value: 2,
              child: Text(
                "Mark as completed",
              ),
            )
          : null,
    ];
  }

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
      trailing: PopupMenuButton(
        onSelected: (itemIndex) {
          print(itemIndex);
          switch (itemIndex) {
            case 0:
              {
                // play video
                playVideo(exercise.videoUrl);
              }
              break;
            case 1:
              {
                // add to logs
                addToLogs(exercise);
              }
              break;
            case 2:
              {
                // mark as completed
                markAsCompleted(exercise);
              }
              break;
            default:
              {
                print("not a valid option selected");
              }
          }
        },
        elevation: 10.0,
        itemBuilder: (context) => menuItems.map((item) {
          return item;
        }).toList(),
      ),
    );
  }
}
