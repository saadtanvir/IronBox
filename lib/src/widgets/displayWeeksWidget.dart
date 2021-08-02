import 'package:flutter/material.dart';
import 'package:ironbox/src/models/userWorkoutPlanDetails.dart';
import 'package:ironbox/src/widgets/listTileWidgets/planWeeksTile.dart';

class DisplayWeeksListWidget extends StatelessWidget {
  final int totalWeeks;
  final Function onWeekSelect;
  final bool isTrainee;
  final Function addWeekToLogs;
  final List<UserWorkoutPlanDetails> userWorkoutPlanDetailsList;
  DisplayWeeksListWidget(
      {Key key,
      this.addWeekToLogs,
      this.userWorkoutPlanDetailsList,
      @required this.totalWeeks,
      @required this.onWeekSelect,
      @required this.isTrainee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: totalWeeks,
      itemBuilder: (context, index) {
        int weekNumber = index + 1;
        return GestureDetector(
          onTap: () {
            onWeekSelect(weekNumber);
          },
          child: PlanWeeksTile(
            weekNumber: weekNumber,
            isTrainee: isTrainee,
            addWeekToLogs: addWeekToLogs,
            // weekProgress: userWorkoutPlanDetailsList[index].progress,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
