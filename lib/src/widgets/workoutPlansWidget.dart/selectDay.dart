import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/widgets/displayDaysWidget.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/addWorkoutPlanDayDetails.dart';

class SelectWorkoutPlanDay extends StatefulWidget {
  final int weekNumber;
  final String planId;
  // final Function onDayTap;

  SelectWorkoutPlanDay(this.planId, this.weekNumber, {Key key})
      : super(key: key);

  @override
  _SelectWorkoutPlanDayState createState() => _SelectWorkoutPlanDayState();
}

class _SelectWorkoutPlanDayState extends State<SelectWorkoutPlanDay> {
  final List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];

  void _onDaySelect(int dayNumber) async {
    // send day week num
    // plan id
    // to next screen
    Get.to(AddWorkoutPlanDayDetails(
        dayNum: dayNumber, planId: widget.planId, weekNum: widget.weekNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Day"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              DisplayWeekDaysWidget(onDayTap: _onDaySelect),
            ],
          ),
        ));
  }
}
