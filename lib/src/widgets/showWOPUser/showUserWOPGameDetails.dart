import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:ironbox/src/controllers/WOPExerciseController.dart';
import 'package:ironbox/src/models/userWorkoutPlanExercise.dart';
import 'package:ironbox/src/models/userWorkoutPlanGame.dart';
import 'package:ironbox/src/widgets/dialogs/playWPExerciseVideo.dart';
import 'package:ironbox/src/widgets/showWOPUser/selectWeek.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/showWOPUser/userWOPExercisesListWidget.dart';
import '../../repositories/user_repo.dart' as userRepo;

import '../../helpers/app_constants.dart' as Constants;

class ShowUserWOPGameDetails extends StatefulWidget {
  final UserWorkoutPlanGame game;
  ShowUserWOPGameDetails(this.game, {Key key}) : super(key: key);

  @override
  _ShowUserWOPGameDetailsState createState() => _ShowUserWOPGameDetailsState();
}

class _ShowUserWOPGameDetailsState extends State<ShowUserWOPGameDetails> {
  WorkoutPlanExerciseController _con = Get.put(WorkoutPlanExerciseController());
  DateFormat _dateFormatter;

  void addExerciseToLog(UserWorkoutPlanExercise exercise) {
    // add to user logs
    print("adding exercise to logs");
    _con.addExerciseToLogs(
        exercise: exercise,
        date: _dateFormatter.format(DateTime.now()),
        categoryId: "1",
        createdBy: userRepo.currentUser.value.id,
        uid: userRepo.currentUser.value.id);
  }

  void markExerciseAsCompleted(UserWorkoutPlanExercise exercise) {
    // change status to 1
    _con.changeExerciseStatus(exercise, "1");
  }

  void playExerciseVideo(String url) {
    Get.dialog(PlayWorkoutPlanExerciseVideoDialog(url));
  }

  @override
  void initState() {
    _con.getGameExercises(widget.game.id);
    _dateFormatter = DateFormat(Constants.dateStringFormat);

    super.initState();
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
      body: RefreshIndicator(
        onRefresh: () {
          return _con.getGameExercises(widget.game.id);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Obx(() {
                return _con.gameExercisesList.isEmpty &&
                        !_con.doneFetchingExercises.value
                    ? const Center(
                        child: const Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : _con.gameExercisesList.isEmpty &&
                            _con.doneFetchingExercises.value
                        ? const Center(
                            child: const Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: const Text("No exercises to show!"),
                            ),
                          )
                        : UserWOPExercisesListWidget(
                            _con.gameExercisesList,
                            addExerciseToLog,
                            markExerciseAsCompleted,
                            playExerciseVideo);
              }),
              // widget.game.exercises.isNotEmpty
              //     ? UserWOPExercisesListWidget(
              //         widget.game.exercises,
              //         addExerciseToLog,
              //         markExerciseAsCompleted,
              //         playExerciseVideo)
              //     : Center(
              //         child: Padding(
              //           padding: const EdgeInsets.only(top: 30.0),
              //           child: Text(
              //             "No exercise in this circuit!",
              //           ),
              //         ),
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}
