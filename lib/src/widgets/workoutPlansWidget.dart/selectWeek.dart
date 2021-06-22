import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/selectDay.dart';

class SelectWeek extends StatelessWidget {
  final int totalWeeks;
  final String createdPlanId;
  SelectWeek(this.createdPlanId, this.totalWeeks, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Week"),
        centerTitle: true,
        actions: [],
      ),
      body: Container(
        child: ListView.separated(
          itemCount: totalWeeks,
          itemBuilder: (context, index) {
            int weekNumber = index + 1;
            return ListTile(
              title: Text(
                "Week $weekNumber",
              ),
              onTap: () {
                // select week number
                // go to days selection
                Get.to(
                  SelectWorkoutPlanDay(createdPlanId, weekNumber),
                  transition: Transition.rightToLeft,
                );
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
