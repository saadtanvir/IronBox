import 'package:ironbox/src/models/workoutPlan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerWorkoutPlanTile extends StatelessWidget {
  final WorkoutPlan plan;
  TrainerWorkoutPlanTile(this.plan, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey[200],
      title: Text("${plan.title}"),
    );
  }
}
