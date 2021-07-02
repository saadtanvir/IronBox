import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/workoutPlanDetails.dart';
import 'package:ironbox/src/widgets/displayWeeksWidget.dart';
import '../../widgets/workoutPlansWidget.dart/selectDay.dart';
import '../../helpers/app_constants.dart' as Constants;

class SelectWeek extends StatefulWidget {
  final int totalWeeks;
  final String planId;
  // final Function onDaySelect;
  SelectWeek(this.planId, this.totalWeeks,
      {Key key, WorkoutPlanDetails planDetails})
      : super(key: key);

  @override
  _SelectWeekState createState() => _SelectWeekState();
}

class _SelectWeekState extends State<SelectWeek> {
  void _onWeekSelect(int weekNumber) async {
    // select week number
    // go to days selection
    Get.to(
      SelectWorkoutPlanDay(widget.planId, weekNumber),
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Week"),
        centerTitle: true,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DisplayWeeksListWidget(
                totalWeeks: widget.totalWeeks, onWeekSelect: _onWeekSelect),
            SizedBox(
              height: 50.0,
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () async {
                  // Get.dialog()
                  Get.defaultDialog(
                      title: "Are you done creating plan ?",
                      middleText: "",
                      textConfirm: "Yes",
                      confirmTextColor: Colors.white,
                      textCancel: "No",
                      buttonColor: Theme.of(context).primaryColor,
                      onConfirm: () {
                        Get.offAllNamed('/TrainerBtmNavBar');
                      });
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 30.0),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  overlayColor: MaterialStateProperty.all(
                    Theme.of(context).accentColor.withOpacity(0.3),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                child: Text(
                  Constants.done,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
