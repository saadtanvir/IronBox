import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/plan.dart';
import 'package:ironbox/src/widgets/planCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPlansListWidget extends StatefulWidget {
  List<Plan> plans = List<Plan>();
  UserPlansListWidget(this.plans);
  @override
  _UserPlansListWidgetState createState() => _UserPlansListWidgetState();
}

class _UserPlansListWidgetState extends State<UserPlansListWidget> {
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
            onTap: () {},
            child: PlanCardWidget(widget.plans[index]),
          );
        },
      ),
    );
  }
}
