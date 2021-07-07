import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/plan.dart';
import 'package:ironbox/src/models/userWorkoutPlan.dart';
import 'package:ironbox/src/models/workoutPlan.dart';
import 'package:ironbox/src/widgets/planCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserWorkoutPlansListWidget extends StatelessWidget {
  final List<UserWorkoutPlan> plans;
  final Function onPlanTap;
  UserWorkoutPlansListWidget(this.plans, this.onPlanTap, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0 * plans.length.toDouble(),
      width: Helper.of(context).getScreenWidth(),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: plans.length,
        itemBuilder: (context, index) {
          print("returing card widget");
          return GestureDetector(
            onTap: () {
              onPlanTap(plans[index]);
            },
            child: PlanCardWidget(plans[index]),
          );
        },
      ),
    );
  }
}
