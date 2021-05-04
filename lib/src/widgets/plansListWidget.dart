import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/models/plan.dart';
import 'package:fitness_app/src/pages/appPlanDetails.dart';
import 'package:fitness_app/src/widgets/categoryCardWidget.dart';
import 'package:fitness_app/src/widgets/planCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlansListWidget extends StatefulWidget {
  List<Plan> plans = List<Plan>();
  PlansListWidget(this.plans);
  @override
  _PlansListWidgetState createState() => _PlansListWidgetState();
}

class _PlansListWidgetState extends State<PlansListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0 * widget.plans.length.toDouble(),
      width: Helper.of(context).getScreenWidth(),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.plans.length,
        itemBuilder: (context, index) {
          print("returing card widget");
          return GestureDetector(
            onTap: () {
              Get.to(AppPlanDetails(widget.plans[index]));
            },
            child: PlanCardWidget(widget.plans[index]),
          );
        },
      ),
    );
  }
}
