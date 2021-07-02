import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/widgets/dialogs/addWorkoutPlanExercise.dart';
import 'package:ironbox/src/widgets/dialogs/addWorkoutPlanGameDialog.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/gamesListWidget.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/showWOPGames.dart';
import '../../helpers/app_constants.dart' as Constants;

class WorkoutPlanGameExercises extends StatefulWidget {
  final String gameId;
  WorkoutPlanGameExercises(this.gameId, {Key key}) : super(key: key);

  @override
  _WorkoutPlanGameExercisesState createState() =>
      _WorkoutPlanGameExercisesState();
}

class _WorkoutPlanGameExercisesState extends State<WorkoutPlanGameExercises> {
  PlansController _con = Get.find(tag: Constants.createWorkoutPlanController);

  @override
  void initState() {
    _con.getWorkoutPlanGameExercises(widget.gameId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Exercise"),
        centerTitle: true,
      ),
      floatingActionButton: _floatingActionButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return _con.workoutPlanExercisesList.isEmpty &&
                      !_con.doneFetchingGameExercises.value
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : _con.workoutPlanExercisesList.isEmpty &&
                          _con.doneFetchingGameExercises.value
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: Text("No exercise added!"),
                          ),
                        )
                      : WorkoutPlanGameExercisesList(
                          _con.workoutPlanExercisesList);
            }),
          ],
        ),
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        // add exercise
        var exerciseData = await Get.to(
          AddWorkoutPlanExerciseWidget(),
          fullscreenDialog: true,
        );
        _con.workoutPlanExercise.description = exerciseData['description'];
        _con.workoutPlanExercise.duration = exerciseData['duration'];
        _con.workoutPlanExercise.gameId = widget.gameId;
        _con.workoutPlanExercise.name = exerciseData['name'];
        _con.workoutPlanExercise.videoUrl = exerciseData['videoLink'];
        _con.workoutPlanExercise.reps = int.parse(exerciseData['reps']);
        _con.createWorkoutPlanExercise(context);
      },
      child: Icon(
        Icons.add,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      splashColor: Theme.of(context).accentColor.withOpacity(0.5),
    );
  }
}
