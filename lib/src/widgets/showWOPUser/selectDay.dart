import 'package:get/get.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/userWorkoutPlan.dart';
import 'package:ironbox/src/models/userWorkoutPlanDetails.dart';
import 'package:ironbox/src/widgets/displayDaysWidget.dart';
import '../../widgets/displayWeeksWidget.dart';
import '../../widgets/showWOPTrainer/showPlanDays.dart';
import '../../models/workoutPlan.dart';
import 'package:flutter/material.dart';
import '../../helpers/app_constants.dart' as Constants;

class SelectUserWOPDay extends StatefulWidget {
  final UserWorkoutPlan plan;
  final int weekNum;
  SelectUserWOPDay(this.plan, this.weekNum, {Key key}) : super(key: key);

  @override
  _SelectUserWOPDayState createState() => _SelectUserWOPDayState();
}

class _SelectUserWOPDayState extends State<SelectUserWOPDay> {
  void onDaySelect(int dayNum) {
    // go to details
    UserWorkoutPlanDetails dayDetail = Helper.getUserWOPSingleDayDetails(
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
      // show details
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
            DisplayWeekDaysWidget(onDayTap: onDaySelect),
          ],
        ),
      ),
    );
  }
}
