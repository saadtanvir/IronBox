import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/models/category.dart';
import 'package:fitness_app/src/models/plan.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class PlanCardWidget extends StatelessWidget {
  Plan plan;
  PlanCardWidget(this.plan);
  @override
  Widget build(BuildContext context) {
    // print("printing card");
    return Container(
      height: 150.0,
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              "${GlobalConfiguration().get('storage_base_url')}${plan.imgUrl}"),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                child: Text(
                  "${plan.name}",
                  overflow: TextOverflow.ellipsis,
                  style: Helper.of(context).textStyle(font: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: Text(
                  "${plan.duration} days",
                  overflow: TextOverflow.ellipsis,
                  style: Helper.of(context).textStyle(font: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
