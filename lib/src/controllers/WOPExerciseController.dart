import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/userWorkoutPlanExercise.dart';
import '../repositories/WOPExercise_repo.dart' as exerciseRepo;

class WorkoutPlanExerciseController extends GetxController {
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

  void changeExerciseStatus(String exerciseId, String status) async {
    exerciseRepo.changeExerciseStatus(exerciseId, status).then((value) {
      if (value) {
        Get.snackbar(
          "Success",
          "Exercise status marked as completed",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {}
    }).onError((error, stackTrace) {
      print("WOP Exercise controller error: $error");
    }).whenComplete(() {});
  }
}
