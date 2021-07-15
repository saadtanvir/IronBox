import 'package:ironbox/src/models/workoutPlan.dart';
import 'package:flutter/material.dart';
import 'package:ironbox/src/widgets/listTileWidgets/trainerWorkoutPlan.dart';

class TrainerWorkoutPlansList extends StatelessWidget {
  final List<WorkoutPlan> plans;
  final Function planOnTap;
  TrainerWorkoutPlansList(this.plans, this.planOnTap, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: plans.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              planOnTap(plans[index]);
            },
            child: TrainerWorkoutPlanTile(plans[index]),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 3.0,
          );
        },
      ),
    );
  }
}
