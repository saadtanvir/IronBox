import 'package:get/get.dart';
import '../../helpers/helper.dart';
import '../../models/userWorkoutPlan.dart';
import '../../models/userWorkoutPlanDetails.dart';
import '../../widgets/displayDaysWidget.dart';
import '../../widgets/showWOPUser/showDayDetails.dart';
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
        planDetailsList: widget.plan.detailsList,
        weekNum: widget.weekNum.toString(),
        dayNum: dayNum.toString());
    print(dayDetail);
    if (dayDetail.dayTitle == null) {
      print("no details for the day");
      Get.defaultDialog(
          title: "No details found !",
          middleText: "",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else {
      // show details
      Get.to(
        ShowUserWOPDayDetails(dayDetail),
        transition: Transition.rightToLeft,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
