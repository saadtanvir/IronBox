import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/plan.dart';
import 'package:ironbox/src/pages/appPlanDetails.dart';
import 'package:ironbox/src/widgets/categoryCardWidget.dart';
import 'package:ironbox/src/widgets/planCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlansListWidget extends StatefulWidget {
  List<Plan> plans = List<Plan>();
  Function planOnTap;
  PlansListWidget(this.plans, this.planOnTap);
  @override
  _PlansListWidgetState createState() => _PlansListWidgetState();
}

class _PlansListWidgetState extends State<PlansListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      // height: 160.0 * widget.plans.length.toDouble(),
      width: Helper.of(context).getScreenWidth(),
      child: ListView.builder(
        // padding: EdgeInsets.only(bottom: 10.0),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.plans.length,
        itemBuilder: (context, index) {
          print("plan video URL: ${widget.plans[index].videoUrl}");
          return GestureDetector(
            onTap: () {
              print(widget.plans[index].videoUrl);
              widget.planOnTap(widget.plans[index]);
            },
            child: PlanCardWidget(widget.plans[index]),
          );
        },
      ),
    );
  }
}
