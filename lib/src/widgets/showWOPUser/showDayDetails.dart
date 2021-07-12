import 'package:cached_network_image/cached_network_image.dart';
import 'package:ironbox/src/models/userWorkoutPlanDetails.dart';
import 'package:ironbox/src/models/userWorkoutPlanGame.dart';
import 'package:ironbox/src/widgets/showWOPUser/selectWeek.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ironbox/src/widgets/showWOPUser/showUserWOPGameDetails.dart';
import 'package:ironbox/src/widgets/showWOPUser/userWOPGamesListWidget.dart';
import '../../repositories/user_repo.dart' as userRepo;
import '../../helpers/app_constants.dart' as Constants;

class ShowUserWOPDayDetails extends StatefulWidget {
  final UserWorkoutPlanDetails details;
  ShowUserWOPDayDetails(this.details, {Key key}) : super(key: key);

  @override
  _ShowUserWOPDayDetailsState createState() => _ShowUserWOPDayDetailsState();
}

class _ShowUserWOPDayDetailsState extends State<ShowUserWOPDayDetails> {
  void onGameTap(UserWorkoutPlanGame game) {
    // go to game details
    Get.to(
      ShowUserWOPGameDetails(game),
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("showing day details of wop to user");
    print(widget.details.userGamesList == null);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.details.dayTitle}",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // display list of games
            widget.details.userGamesList != null &&
                    widget.details.userGamesList.isNotEmpty
                ? UserWorkoutPlanGamesListWidget(
                    widget.details.userGamesList, onGameTap)
                : Text("No games to perform!"),
            SizedBox(
              height: 00.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Calories Burn: ",
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  "${widget.details.calBurn}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Average Calories: ",
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  "${widget.details.avgCal}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
