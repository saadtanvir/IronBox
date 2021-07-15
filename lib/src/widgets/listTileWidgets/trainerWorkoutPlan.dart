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
      trailing: Container(
        width: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                "${plan.rating.rating.toStringAsFixed(1)}",
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
