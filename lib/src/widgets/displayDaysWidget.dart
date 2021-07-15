import 'package:flutter/material.dart';

class DisplayWeekDaysWidget extends StatelessWidget {
  // final int weekNumber;
  final Function onDayTap;
  final List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  DisplayWeekDaysWidget({Key key, @required this.onDayTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          int dayNumber = index + 1;
          return ListTile(
            title: Text("${weekDays[index]}"),
            onTap: () {
              onDayTap(dayNumber);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
