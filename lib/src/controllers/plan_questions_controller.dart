import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/questions.dart';
import 'package:ironbox/src/repositories/plan_questions_repo.dart'
    as questionRepo;

class PlanQuestionController extends GetxController {
  var planQuestionsList = <Question>[].obs;

  // progress variables
  var doneFetchingPlanQuestions = false.obs;

  void getQuestions(String categoryId) async {
    doneFetchingPlanQuestions.value = false;
    planQuestionsList.clear();

    Stream<Question> stream = await questionRepo.getPlanQuestions(categoryId);
    stream.listen((Question question) {
      planQuestionsList.add(question);
    }, onError: (e) {
      print("Plan Question Controller Error: $e");
    }, onDone: () {
      doneFetchingPlanQuestions.value = true;
    });
  }

  Future<bool> addQuestionForTrainer(
      {@required String questionId,
      @required String trainerId,
      @required String isOptional}) async {
    bool isAdded;
    await questionRepo
        .addQuestionForTrainer(
            questionId: questionId,
            trainerId: trainerId,
            isOptional: isOptional)
        .then((value) {
      isAdded = value;
    }).onError((error, stackTrace) {
      print("Plan Question Controller Error: $error");
      isAdded = false;
    }).whenComplete(() {});
    return isAdded;
  }
}
