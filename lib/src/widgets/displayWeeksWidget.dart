import 'package:flutter/material.dart';

class DisplayWeeksListWidget extends StatelessWidget {
  final int totalWeeks;
  final Function onWeekSelect;
  DisplayWeeksListWidget(
      {Key key, @required this.totalWeeks, @required this.onWeekSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: totalWeeks,
        itemBuilder: (context, index) {
          int weekNumber = index + 1;
          return ListTile(
            title: Text(
              "Week $weekNumber",
            ),
            onTap: () {
              onWeekSelect(weekNumber);
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
