import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/userWorkoutPlanExercise.dart';
import '../repositories/WOPExercise_repo.dart' as exerciseRepo;
import '../helpers/app_constants.dart' as Constants;

class WorkoutPlanExerciseController extends GetxController {
  List<UserWorkoutPlanExercise> gameExercisesList =
      List<UserWorkoutPlanExercise>().obs;

  // progress variables
  var doneFetchingExercises = false.obs;
  WorkoutPlanExerciseController();

  Future<void> getGameExercises(String gameId) async {
    gameExercisesList.clear();
    doneFetchingExercises.value = false;
    final Stream<UserWorkoutPlanExercise> stream =
        await exerciseRepo.getGameExercises(gameId);
    stream.listen((UserWorkoutPlanExercise _exercise) {
      gameExercisesList.add(_exercise);
    }, onError: (e) {
      print("WOP Exercise Controller Error: $e");
    }, onDone: () {
      doneFetchingExercises.value = true;
    });
  }

  void addExerciseToLogs(
      {@required UserWorkoutPlanExercise exercise,
      @required String date,
      @required String categoryId,
      @required String createdBy,
      @required String uid}) async {
    exerciseRepo
        .addExerciseToLog(
            exercise: exercise,
            date: date,
            categoryId: categoryId,
            createdBy: createdBy,
            userId: uid)
        .then((value) {
      if (value) {
        Get.snackbar(
          "Success",
          "Exercise added to logs",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {}
    }).onError((error, stackTrace) {
      print("workout plan exercise controller error: $error");
    }).whenComplete(() {});
  }

  void changeExerciseStatus(
      UserWorkoutPlanExercise exercise, String status) async {
    exerciseRepo.changeExerciseStatus(exercise.id, status).then((value) {
      if (value) {
        getGameExercises(exercise.userWOPGameId);
        Get.snackbar(
          Constants.success,
          "Exercise status marked as completed",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          Constants.failed,
          "Status not changed.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }).onError((error, stackTrace) {
      print("WOP Exercise controller error: $error");
    }).whenComplete(() {});
  }
}
