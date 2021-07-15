import 'package:flutter/material.dart';
import '../../models/workoutPlanGame.dart';
import '../../widgets/workoutPlansWidget.dart/workoutPlanExercisesList.dart';

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
            const SizedBox(
              height: 20.0,
            ),
            widget.game.exercisesList.isNotEmpty
                ? WorkoutPlanGameExercisesList(widget.game.exercisesList)
                : const Center(
                    child: const Text("No exercises to show!"),
                  ),
          ],
        ),
      ),
    );
  }
}
