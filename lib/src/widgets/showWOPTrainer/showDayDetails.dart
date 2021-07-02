import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/workoutPlanDetails.dart';
import '../workoutPlansWidget.dart/selectDay.dart';
import '../../helpers/app_constants.dart' as Constants;

class WorkoutPlanDayDetail extends StatefulWidget {
  final WorkoutPlanDetails planDetails;
  const WorkoutPlanDayDetail(this.planDetails, {Key key}) : super(key: key);

  @override
  _WorkoutPlanDayDetailState createState() => _WorkoutPlanDayDetailState();
}

class _WorkoutPlanDayDetailState extends State<WorkoutPlanDayDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.planDetails.dayTitle}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
