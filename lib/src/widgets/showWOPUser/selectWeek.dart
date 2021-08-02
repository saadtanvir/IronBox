import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import '../../widgets/showWOPUser/selectDay.dart';
import '../../models/userWorkoutPlan.dart';
import '../../widgets/displayWeeksWidget.dart';
import 'package:flutter/material.dart';
import '../../helpers/app_constants.dart' as Constants;

class SelectUserWOPWeek extends StatefulWidget {
  final UserWorkoutPlan plan;
  SelectUserWOPWeek(this.plan, {Key key}) : super(key: key);

  @override
  _SelectUserWOPWeekState createState() => _SelectUserWOPWeekState();
}

class _SelectUserWOPWeekState extends State<SelectUserWOPWeek> {
  PlansController _con = Get.find(tag: Constants.userWOPDetailsController);
  void _onWeekTap(int weekNum) async {
    // go to days
    Get.to(
      SelectUserWOPDay(widget.plan, weekNum),
      transition: Transition.rightToLeft,
    );
  }

  void _addWeekToLogs(int weekNum) async {
    // show popup if week num is > 1 and
    // progress of previous week is not 100
    // add week to logs
    _con.addUserWOPWeekToLogs(
        context: context, planId: widget.plan.id, weekNum: weekNum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Week",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DisplayWeeksListWidget(
              totalWeeks: widget.plan.durationInWeeks,
              onWeekSelect: _onWeekTap,
              isTrainee: true,
              // userWorkoutPlanDetailsList: widget.plan.detailsList,
              addWeekToLogs: _addWeekToLogs,
            ),
          ],
        ),
      ),
    );
  }
}
