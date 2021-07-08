import 'package:cached_network_image/cached_network_image.dart';
import 'package:ironbox/src/models/userWorkoutPlanExercise.dart';
import 'package:ironbox/src/models/userWorkoutPlanGame.dart';
import 'package:ironbox/src/widgets/showWOPUser/selectWeek.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/showWOPUser/userWOPExercisesListWidget.dart';
import '../../helpers/app_constants.dart' as Constants;

class ShowUserWOPGameDetails extends StatefulWidget {
  final UserWorkoutPlanGame game;
  ShowUserWOPGameDetails(this.game, {Key key}) : super(key: key);

  @override
  _ShowUserWOPGameDetailsState createState() => _ShowUserWOPGameDetailsState();
}

class _ShowUserWOPGameDetailsState extends State<ShowUserWOPGameDetails> {
  void onExerciseTap(UserWorkoutPlanExercise exercise) {
    // do whatever you want
  }
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
            widget.game.exercises.isNotEmpty
                ? UserWOPExercisesListWidget(
                    widget.game.exercises, onExerciseTap)
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        "No exercise in this circuit!",
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
