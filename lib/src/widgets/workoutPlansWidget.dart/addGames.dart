import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/models/workoutPlanGame.dart';
import 'package:ironbox/src/widgets/dialogs/addWorkoutPlanGameDialog.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/gamesListWidget.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/showWPGameExercises.dart';
import '../../helpers/app_constants.dart' as Constants;

class AddWorkoutPlanGame extends StatefulWidget {
  final String detailsId;
  AddWorkoutPlanGame(this.detailsId, {Key key}) : super(key: key);

  @override
  _AddWorkoutPlanGameState createState() => _AddWorkoutPlanGameState();
}

class _AddWorkoutPlanGameState extends State<AddWorkoutPlanGame> {
  PlansController _con = Get.find(tag: Constants.createWorkoutPlanController);

  void onGameTap(WorkoutPlanGame game) {
    Get.to(
      WorkoutPlanGameExercises(game.id),
      transition: Transition.rightToLeft,
    );
  }

  @override
  void initState() {
    _con.getWorkoutPlanGames(widget.detailsId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Games"),
        centerTitle: true,
      ),
      floatingActionButton: _floatingActionButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return _con.workoutPlanGamesList.isEmpty &&
                      !_con.doneFetchingWorkoutPlanGames.value
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : _con.workoutPlanGamesList.isEmpty &&
                          _con.doneFetchingWorkoutPlanGames.value
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: Text(
                              "No game added!",
                            ),
                          ),
                        )
                      : WorkoutPlanGamesList(
                          _con.workoutPlanGamesList, onGameTap);
            }),
          ],
        ),
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        // show dialog
        // show form
        // take form details
        // add game in games list
        var data = await Get.dialog(AddWorkoutPlanGameDialog());
        // print(data);
        _con.workoutPlanGame.detailsId = widget.detailsId;
        _con.workoutPlanGame.name = data['name'];
        _con.workoutPlanGame.sets = int.parse(data['sets']);
        _con.createWorkoutPlanGame(context);
      },
      child: Icon(
        Icons.add,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      splashColor: Theme.of(context).accentColor.withOpacity(0.5),
    );
  }
}
