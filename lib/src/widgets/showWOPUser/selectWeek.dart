import 'package:get/get.dart';
import 'package:ironbox/src/widgets/showWOPUser/selectDay.dart';
import '../../models/userWorkoutPlan.dart';
import '../../widgets/displayWeeksWidget.dart';
import '../../widgets/showWOPTrainer/showPlanDays.dart';
import '../../models/workoutPlan.dart';
import 'package:flutter/material.dart';
import '../../helpers/app_constants.dart' as Constants;

class SelectUserWOPWeek extends StatefulWidget {
  final UserWorkoutPlan plan;
  SelectUserWOPWeek(this.plan, {Key key}) : super(key: key);

  @override
  _SelectUserWOPWeekState createState() => _SelectUserWOPWeekState();
}

class _SelectUserWOPWeekState extends State<SelectUserWOPWeek> {
  void _onWeekTap(int weekNum) async {
    // go to days
    Get.to(
      SelectUserWOPDay(widget.plan, weekNum),
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
