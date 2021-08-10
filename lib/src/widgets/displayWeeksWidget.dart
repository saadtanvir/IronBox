import 'package:flutter/material.dart';
import '../helpers/helper.dart';
import '../models/userWorkoutPlanDetails.dart';
import '../widgets/listTileWidgets/planWeeksTile.dart';

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
        double weekProgress = 0.0;
        if (userWorkoutPlanDetailsList != null) {
          if (userWorkoutPlanDetailsList.isNotEmpty) {
            weekProgress = Helper.getUserWOPWeekProgress(
                weekNumber.toString(), userWorkoutPlanDetailsList);
          }
        }
        print(weekProgress);
        return GestureDetector(
          onTap: () {
            onWeekSelect(weekNumber);
          },
          child: PlanWeeksTile(
            weekNumber: weekNumber,
            isTrainee: isTrainee,
            addWeekToLogs: addWeekToLogs,
            weekProgress: weekProgress,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
