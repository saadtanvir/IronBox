import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PlanWeeksTile extends StatelessWidget {
  final int weekNumber;
  final bool isTrainee;
  final double weekProgress;
  final Function addWeekToLogs;
  List<PopupMenuItem> menuItems;
  PlanWeeksTile(
      {Key key,
      this.addWeekToLogs,
      @required this.weekNumber,
      @required this.isTrainee,
      this.weekProgress})
      : super(key: key) {
    this.menuItems = [
      PopupMenuItem(
        value: 0,
        child: Text(
          "Add to logs",
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Week $weekNumber",
      ),
      leading: isTrainee && weekProgress != null
          ? CircularPercentIndicator(
              percent: weekProgress / 100,
              radius: 40.0,
              lineWidth: 5.0,
              backgroundColor: Colors.grey[200],
              progressColor: Colors.green,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${weekProgress}%",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            )
          : null,
      trailing: isTrainee
          ? PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (itemIndex) {
                print(itemIndex);
                switch (itemIndex) {
                  case 0:
                    {
                      if (addWeekToLogs == null) {
                        print("Error: Add week to log function is null.");
                      } else {
                        addWeekToLogs(weekNumber);
                      }
                    }
                    break;
                  case 1:
                    {}
                    break;
                  case 2:
                    {}
                    break;
                  default:
                    {
                      print("not a valid option selected");
                    }
                }
              },
              elevation: 10.0,
              itemBuilder: (context) => menuItems.map((item) {
                return item;
              }).toList(),
            )
          : null,
    );
  }
}
