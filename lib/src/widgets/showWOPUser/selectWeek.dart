import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/widgets/dialogs/confirmationDialog.dart';
import '../../controllers/plans_controller.dart';
import '../../widgets/showWOPUser/selectDay.dart';
import '../../models/userWorkoutPlan.dart';
import '../../widgets/displayWeeksWidget.dart';
import 'package:flutter/material.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

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
    // show alert if week num is > 1 and
    // progress of previous week is not 100
    // add week to logs

    if (weekNum > 1) {
      int previousWeekNum = weekNum - 1;
      double previousWeekProgress = Helper.getUserWOPWeekProgress(
          previousWeekNum.toString(), widget.plan.detailsList);
      if (previousWeekProgress < 100.0) {
        // show alert
        // previous week is not completed
        // do you want to map next week from Monday ?
        // if yes, then map
        Platform.isAndroid
            ? showDialog(
                context: context,
                builder: (_) {
                  return _confirmationDialog(
                      "Your previous week is incomplete. Do you want to add this to logs?",
                      weekNum);
                })
            : showCupertinoDialog(
                context: context,
                builder: (_) {
                  return _confirmationDialog(
                      "Your previous week is incomplete. Do you want to add this to logs?",
                      weekNum);
                });
      } else {
        _con.addUserWOPWeekToLogs(
            context: context,
            planId: widget.plan.id,
            weekNum: weekNum,
            categoryId: "1",
            createdBy: userRepo.currentUser.value.id,
            userId: userRepo.currentUser.value.id);
      }
    } else {
      _con.addUserWOPWeekToLogs(
          context: context,
          planId: widget.plan.id,
          weekNum: weekNum,
          categoryId: "1",
          createdBy: userRepo.currentUser.value.id,
          userId: userRepo.currentUser.value.id);
    }
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
              userWorkoutPlanDetailsList: widget.plan.detailsList,
              addWeekToLogs: _addWeekToLogs,
            ),
          ],
        ),
      ),
    );
  }

  Widget _confirmationDialog(String message, int weekNum) {
    return Platform.isAndroid
        ? AlertDialog(
            title: Text(
              message,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Get.back();
                  _con.addUserWOPWeekToLogs(
                      context: context,
                      planId: widget.plan.id,
                      weekNum: weekNum,
                      categoryId: "1",
                      createdBy: userRepo.currentUser.value.id,
                      userId: userRepo.currentUser.value.id);
                },
                // style: ButtonStyle(
                //   padding: MaterialStateProperty.all(
                //     const EdgeInsets.symmetric(horizontal: 30.0),
                //   ),
                //   backgroundColor:
                //       MaterialStateProperty.all(Theme.of(context).primaryColor),
                //   overlayColor: MaterialStateProperty.all(
                //     Theme.of(context).accentColor.withOpacity(0.3),
                //   ),
                //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //     RoundedRectangleBorder(
                //       borderRadius:
                //           const BorderRadius.all(Radius.circular(15.0)),
                //     ),
                //   ),
                // ),
                child: Text(
                  "Yes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Get.back();
                },
                // style: ButtonStyle(
                //   padding: MaterialStateProperty.all(
                //     const EdgeInsets.symmetric(horizontal: 30.0),
                //   ),
                //   backgroundColor:
                //       MaterialStateProperty.all(Theme.of(context).primaryColor),
                //   overlayColor: MaterialStateProperty.all(
                //     Theme.of(context).accentColor.withOpacity(0.3),
                //   ),
                //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //     RoundedRectangleBorder(
                //       borderRadius:
                //           const BorderRadius.all(Radius.circular(15.0)),
                //     ),
                //   ),
                // ),
                child: Text(
                  "No",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          )
        : CupertinoAlertDialog(
            content: Text(
              message,
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                  _con.addUserWOPWeekToLogs(
                      context: context,
                      planId: widget.plan.id,
                      weekNum: weekNum,
                      categoryId: "1",
                      createdBy: userRepo.currentUser.value.id,
                      userId: userRepo.currentUser.value.id);
                },
                child: Text("Yes"),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                },
                child: Text("No"),
              ),
            ],
          );
  }
}
