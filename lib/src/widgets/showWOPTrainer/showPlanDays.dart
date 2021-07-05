import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/workoutPlanDetails.dart';
import 'package:ironbox/src/widgets/displayDaysWidget.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/showWOPTrainer/showDayDetails.dart';
import '../../models/workoutPlan.dart';
import 'package:flutter/material.dart';
import '../../helpers/app_constants.dart' as Constants;

class ShowPlanDaysList extends StatefulWidget {
  final int weekNum;
  final WorkoutPlan plan;
  ShowPlanDaysList(this.plan, this.weekNum, {Key key}) : super(key: key);

  @override
  _ShowPlanDaysListState createState() => _ShowPlanDaysListState();
}

class _ShowPlanDaysListState extends State<ShowPlanDaysList> {
  void _onDaySelect(int dayNum) async {
    // go to next page
    // display day name
    // display all its games
    // get single day details from Helper
    WorkoutPlanDetails dayDetail = Helper.getWOPSingleDayDetails(
        planDetailsList: widget.plan.details,
        weekNum: widget.weekNum.toString(),
        dayNum: dayNum.toString());
    print(dayDetail);
    if (dayDetail.dayTitle == null) {
      Get.defaultDialog(
          title: "No details found !",
          middleText: "",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else {
      Get.to(WorkoutPlanDayDetail(dayDetail),
          transition: Transition.rightToLeft);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Day",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DisplayWeekDaysWidget(onDayTap: _onDaySelect),
          ],
        ),
      ),
    );
  }
}
