import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/userWorkoutPlanDetails.dart';
import 'package:ironbox/src/models/userWorkoutPlanExercise.dart';
import 'package:ironbox/src/models/userWorkoutPlanGame.dart';
import '../repositories/WOPGame_repo.dart' as gameRepo;
import '../repositories/WOPDayDetail_repo.dart' as detailsRepo;
import '../helpers/app_constants.dart' as Constants;

class WorkoutPlanDetailsController extends GetxController {
  var userWOPDayDetails = new UserWorkoutPlanDetails().obs;
  List<UserWorkoutPlanGame> dayGamesList = List<UserWorkoutPlanGame>().obs;

  // progress variables
  var doneFetchingDayGames = false.obs;
  WorkoutPlanDetailsController();

  void getDayDetails(
      {@required String planId,
      @required String weekNum,
      @required String dayNum}) async {
    detailsRepo
        .getSingleDayDetails(planId: planId, weekNum: weekNum, dayNum: dayNum)
        .then((UserWorkoutPlanDetails details) {
      userWOPDayDetails.value = details;
    }).onError((error, stackTrace) {
      print("WOP Game Controller Error: $error");
    }).whenComplete(() {});
  }

  void getDayGames(UserWorkoutPlanDetails details) async {
    dayGamesList.clear();
    doneFetchingDayGames.value = false;
    final Stream<UserWorkoutPlanGame> stream =
        await gameRepo.getDayGames(details.id);

    stream.listen((UserWorkoutPlanGame game) {
      dayGamesList.add(game);
    }, onError: (e) {
      print("WOP Game Controller Error: $e");
    }, onDone: () {
      doneFetchingDayGames.value = true;
    });
  }
}
