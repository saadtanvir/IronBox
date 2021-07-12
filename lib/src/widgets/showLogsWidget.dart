import 'dart:math';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/logs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;

class ShowLogsWidget extends StatefulWidget {
  List<Logs> logsList;
  final bool canDelete;
  final bool canUpdate;
  final Function updateLogStatus;
  final Function deleteLog;
  ShowLogsWidget(
      {this.logsList,
      this.canDelete,
      this.canUpdate,
      this.deleteLog,
      this.updateLogStatus});
  @override
  _ShowLogsWidgetState createState() => _ShowLogsWidgetState();
}

class _ShowLogsWidgetState extends State<ShowLogsWidget> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // not meant to be rebuilt with a different list of steps
    // unless a key is provided
    // in order to distinguish the old stepper from the new one
    return Stepper(
      key: Key(Random.secure().nextDouble().toString()),
      currentStep: _currentIndex,
      steps: getStepsList(widget.logsList),
      physics: ClampingScrollPhysics(),
      onStepTapped: _stepTapped,
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.canDelete
                ? TextButton(
                    onPressed: () async {
                      // show dialog "are you sure you want to delete ?"
                      // delete logsList[currentIndex] from logs list
                      // and update logs
                      Get.defaultDialog(
                        title: "Are you sure you want to delete ?",
                        titleStyle: TextStyle(
                          fontSize: 15.0,
                        ),
                        content: SizedBox(
                          height: 0.0,
                        ),
                        barrierDismissible: false,
                        textCancel: "Cancel",
                        textConfirm: "Yes",
                        confirmTextColor: Colors.white,
                        buttonColor: Theme.of(context).primaryColor,
                        onCancel: () {},
                        onConfirm: () {
                          widget.deleteLog(widget.logsList[_currentIndex]);
                          Get.back();
                        },
                      );
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      overlayColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor.withOpacity(0.8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  )
                : SizedBox(
                    width: 0.0,
                  ),
            SizedBox(
              width: 5.0,
            ),
            widget.logsList[_currentIndex].isCompleted == 0 && widget.canUpdate
                ? TextButton(
                    onPressed: () async {
                      // make this step BG color light green
                      // remove this completed button
                      // update log status to completed
                      widget.updateLogStatus(
                          widget.logsList[_currentIndex].id, "1");
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      overlayColor:
                          MaterialStateProperty.all(Colors.green[200]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    child: Text(
                      "Completed",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  )
                : SizedBox(
                    width: 0.0,
                  ),
          ],
        );
      },
    );
  }

  void _stepTapped(int stepIndex) {
    setState(() {
      _currentIndex = stepIndex;
    });
  }

  // TODO: make this func in helper
  List<Step> getStepsList(List<Logs> logsList) {
    List<Step> logSteps = [];
    if (logsList.isNotEmpty) {
      logsList.forEach((log) {
        int index = logsList.indexOf(log);
        logSteps.add(Step(
          // isActive: true,
          state: StepState.indexed,
          title: Text("${log.title}"),
          content: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            color: log.isCompleted == 1
                ? Colors.green[400]
                : Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${log.title}",
                        style: Helper.of(context).textStyle(
                            color: log.isCompleted == 1
                                ? Colors.white
                                : Theme.of(context).accentColor),
                      ),
                      Spacer(),
                      Text(
                        "${log.duration}min",
                        style: Helper.of(context).textStyle(
                            color: log.isCompleted == 1
                                ? Colors.white
                                : Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "${log.description}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Helper.of(context).textStyle(
                        color: log.isCompleted == 1
                            ? Colors.white
                            : Theme.of(context).accentColor),
                  ),
                ],
              ),
            ),
          ),
        ));
      });
    }
    return logSteps;
  }
}
