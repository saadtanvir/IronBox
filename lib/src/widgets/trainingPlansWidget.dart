import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/plan.dart';
import 'package:ironbox/src/widgets/categoryCardWidget.dart';
import 'package:flutter/material.dart';

class TrainingPlansWidget extends StatefulWidget {
  // receive list of plans

  @override
  _TrainingPlansWidgetState createState() => _TrainingPlansWidgetState();
}

class _TrainingPlansWidgetState extends State<TrainingPlansWidget> {
  List<String> plansImages = [
    "https://d1heoihvzm7u4h.cloudfront.net/2ea91972f9230cdc5193dca33f3e9901f15d08ec_August_banner_06.jpg",
    "https://runningmagazine.ca/wp-content/uploads/2020/07/Screen-Shot-2020-07-19-at-4.10.38-PM-1200x675.jpg",
    "https://media3.s-nbcnews.com/i/newscms/2019_51/1406125/fruits-veggies-today-main-190130_5fce180c233a626539c5c65792a13462.jpg"
  ];

  List<String> plansNames = ["Weight Gain", "Workout Plans", "Reduce weight"];
  List<String> durations = ["6 weeks", "2 weeks", "2.5 weeks"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0 * plansImages.length.toDouble(),
      width: Helper.of(context).getScreenWidth(),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: plansImages.length,
        itemBuilder: (context, index) {
          print("returing card widget");
          return GestureDetector(
            onTap: () {},
            child: Center(child: Text("Create separate card for them")),
          );
        },
      ),
    );
  }
}
