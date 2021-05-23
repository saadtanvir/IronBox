import 'package:fitness_app/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import '../helpers/app_constants.dart' as Constants;

class UpcomingChallengesWidget extends StatefulWidget {
  List<String> upcomingChallenges;
  UpcomingChallengesWidget(this.upcomingChallenges);
  @override
  _UpcomingChallengesWidgetState createState() =>
      _UpcomingChallengesWidgetState();
}

class _UpcomingChallengesWidgetState extends State<UpcomingChallengesWidget> {
  // List<String> upcomingChallenges = [
  //   "Stay hydrated",
  //   "Workout 45min",
  //   "3*15 pushups",
  //   "Take your meal",
  //   "15min jog",
  //   "Hit gym twice",
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Helper.of(context).getScreenWidth(),
      child: Card(
          elevation: 5.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Constants.upcomingChallenges,
                  style: Helper.of(context).textStyle(
                      color: Theme.of(context).primaryColor,
                      font: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                widget.upcomingChallenges.isEmpty
                    ? Text("You have no challenges to meet. Hurrah!")
                    : ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: widget.upcomingChallenges.map((challenge) {
                          return Text(
                            "- $challenge",
                            // overflow: TextOverflow.ellipsis,
                            style: Helper.of(context).textStyle(
                                color: Theme.of(context).accentColor),
                          );
                        }).toList(),
                      ),
              ],
            ),
          )),
    );
  }
}
