import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/addWorkoutPlanDayDetails.dart';

class SelectWorkoutPlanDay extends StatelessWidget {
  final int weekNumber;
  final String planId;
  final List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  SelectWorkoutPlanDay(this.planId, this.weekNumber, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Day"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) {
            int dayNumber = index + 1;
            return ListTile(
              title: Text("${weekDays[index]}"),
              onTap: () {
                // send day week num
                // plan id
                // to next screen
                Get.to(AddWorkoutPlanDayDetails(
                    dayNum: dayNumber, planId: planId, weekNum: weekNumber));
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
