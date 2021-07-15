import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/helper.dart';
import '../../models/workoutPlanDetails.dart';
import '../../models/workoutPlanGame.dart';
import '../showWOPTrainer/showGameDetails.dart';
import '../workoutPlansWidget.dart/gamesListWidget.dart';
import '../../helpers/app_constants.dart' as Constants;

class WorkoutPlanDayDetail extends StatefulWidget {
  final WorkoutPlanDetails planDetails;
  const WorkoutPlanDayDetail(this.planDetails, {Key key}) : super(key: key);

  @override
  _WorkoutPlanDayDetailState createState() => _WorkoutPlanDayDetailState();
}

class _WorkoutPlanDayDetailState extends State<WorkoutPlanDayDetail> {
  List<WorkoutPlanGame> gamesList = [];

  void onGameTap(WorkoutPlanGame game) {
    // go to exercises
    Get.to(
      WorkoutPlanGameDetails(game),
      transition: Transition.rightToLeft,
    );
  }

  @override
  void initState() {
    gamesList = widget.planDetails.gamesList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.planDetails.dayTitle}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gamesList.isNotEmpty
                ? WorkoutPlanGamesList(gamesList, onGameTap)
                : const Center(
                    child: const Text(
                      "No games to show!",
                    ),
                  ),
            const SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Average Calories Burn: ${Helper.calAvgCal(minCal: widget.planDetails.minCal, maxCal: widget.planDetails.maxCal)}"),
            ),
          ],
        ),
      ),
    );
  }
}
