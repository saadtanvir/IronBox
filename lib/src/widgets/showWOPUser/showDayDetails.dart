import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart';
import 'package:ironbox/src/controllers/WOPGameController.dart';
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
  WorkoutPlanDetailsController _con = Get.put(WorkoutPlanDetailsController());

  void onGameTap(UserWorkoutPlanGame game) {
    // go to game details
    Get.to(
      ShowUserWOPGameDetails(game),
      transition: Transition.rightToLeft,
    );
  }

  @override
  void initState() {
    // _con.getDayGames(widget.details);
    _con.getDayDetails(
        planId: widget.details.userPlanId,
        weekNum: widget.details.weekNumber,
        dayNum: widget.details.dayNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("id is:");
    print(_con.userWOPDayDetails.value.id == null);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.details.dayTitle}",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return _con.userWOPDayDetails.value.id == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    // display list of games
                    _con.userWOPDayDetails.value.userGamesList != null &&
                            _con.userWOPDayDetails.value.userGamesList
                                .isNotEmpty
                        ? UserWorkoutPlanGamesListWidget(
                            _con.userWOPDayDetails.value.userGamesList,
                            onGameTap)
                        : Center(
                            child: Text("No games to show"),
                          ),
                    // widget.details.userGamesList != null &&
                    //         widget.details.userGamesList.isNotEmpty
                    //     ? UserWorkoutPlanGamesListWidget(
                    //         widget.details.userGamesList, onGameTap)
                    //     : Text("No games to perform!"),
                    SizedBox(
                      height: 0.0,
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
                );
        }),
      ),
    );
  }
}
