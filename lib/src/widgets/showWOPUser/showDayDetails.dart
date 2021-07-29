import '../../controllers/WOPGameController.dart';
import '../../models/userWorkoutPlanDetails.dart';
import '../../models/userWorkoutPlanGame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/showWOPUser/showUserWOPGameDetails.dart';
import '../../widgets/showWOPUser/userWOPGamesListWidget.dart';

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
    // print("id is:");
    // print(_con.userWOPDayDetails.value.id == null);
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
              ? const Center(
                  child: const CircularProgressIndicator(),
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
                        : const Center(
                            child: const Text("No games to show"),
                          ),
                    // widget.details.userGamesList != null &&
                    //         widget.details.userGamesList.isNotEmpty
                    //     ? UserWorkoutPlanGamesListWidget(
                    //         widget.details.userGamesList, onGameTap)
                    //     : Text("No games to perform!"),
                    const SizedBox(
                      height: 0.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Calories Burn: ",
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "${widget.details.calBurn}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Average Calories: ",
                        ),
                        const SizedBox(
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
