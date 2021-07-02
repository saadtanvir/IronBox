import 'package:get/get.dart';
import 'package:ironbox/src/widgets/displayWeeksWidget.dart';
import 'package:ironbox/src/widgets/showWOPTrainer/showPlanDays.dart';
import '../../models/workoutPlan.dart';
import 'package:flutter/material.dart';
import '../../helpers/app_constants.dart' as Constants;

class ShowPlanWeeksList extends StatefulWidget {
  final WorkoutPlan plan;
  ShowPlanWeeksList(this.plan, {Key key}) : super(key: key);

  @override
  _ShowPlanWeeksListState createState() => _ShowPlanWeeksListState();
}

class _ShowPlanWeeksListState extends State<ShowPlanWeeksList> {
  void _onWeekTap(int weekNum) async {
    // go to days
    Get.to(
      ShowPlanDaysList(widget.plan, weekNum),
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Week",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DisplayWeeksListWidget(
                totalWeeks: widget.plan.durationInWeeks,
                onWeekSelect: _onWeekTap),
          ],
        ),
      ),
    );
  }
}
