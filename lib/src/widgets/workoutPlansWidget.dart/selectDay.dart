import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectWorkoutPlanDay extends StatelessWidget {
  final int weekNumber;
  final String planId;
  final List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  SelectWorkoutPlanDay(this.planId, this.weekNumber, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Day"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) {
            int dayNumber = index + 1;
            return ListTile(
              title: Text("${weekDays[index]}"),
              onTap: () {
                // send day week num
                // plan id
                // to next screen
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
