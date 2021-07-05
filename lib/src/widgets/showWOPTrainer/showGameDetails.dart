import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/workoutPlanDetails.dart';
import 'package:ironbox/src/models/workoutPlanGame.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/gamesListWidget.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/workoutPlanExercisesList.dart';
import '../workoutPlansWidget.dart/selectDay.dart';
import '../../helpers/app_constants.dart' as Constants;

class WorkoutPlanGameDetails extends StatefulWidget {
  final WorkoutPlanGame game;
  WorkoutPlanGameDetails(this.game, {Key key}) : super(key: key);

  @override
  _WorkoutPlanGameDetailsState createState() => _WorkoutPlanGameDetailsState();
}

class _WorkoutPlanGameDetailsState extends State<WorkoutPlanGameDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.game.name}",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Number of sets: ${widget.game.sets}",
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            widget.game.exercisesList.isNotEmpty
                ? WorkoutPlanGameExercisesList(widget.game.exercisesList)
                : Center(
                    child: Text("No exercises to show!"),
                  ),
          ],
        ),
      ),
    );
  }
}
