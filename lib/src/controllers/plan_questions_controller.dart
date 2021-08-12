import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/planRequest.dart';
import 'package:ironbox/src/models/questions.dart';
import 'package:ironbox/src/models/trainerQuestion.dart';
import 'package:ironbox/src/repositories/plan_questions_repo.dart'
    as questionRepo;

class PlanQuestionController extends GetxController {
  PlanRequest planRequest = new PlanRequest();
  var planQuestionsList = <Question>[].obs;
  var trainerQuestions = <TrainerQuestion>[].obs;

  // progress variables
  var doneFetchingPlanQuestions = false.obs;
  // var doneFetchingTrainerQuestions = false.obs;
  var doneFetchingQuestions = false.obs;

  void submitPlanRequest(List<Map> answers) async {
    questionRepo
        .submitCustomPlanRequest(planRequest, answers)
        .then((value) {
          print(value);
        })
        .onError((error, stackTrace) {})
        .whenComplete(() {});
  }

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

  void getTrainerQuestions(String trainerId) async {
    doneFetchingQuestions.value = false;
    trainerQuestions.clear();

    Stream<TrainerQuestion> stream =
        await questionRepo.getTrainerQuestions(trainerId);
    stream.listen((TrainerQuestion question) {
      trainerQuestions.add(question);
    }, onError: (e) {
      print("Plan Question Controller Error: $e");
    }, onDone: () {
      doneFetchingQuestions.value = true;
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

  Future<bool> removeQuestionFromTrainer(
      String trainerId, String originalQuestionId) async {
    bool isRemoved;
    await questionRepo
        .removeQuestionFromTrainer(trainerId, originalQuestionId)
        .then((value) {
      isRemoved = value;
    }).onError((error, stackTrace) {
      print("Plan Question Controller Error: $error");
      isRemoved = false;
    }).whenComplete(() {});
    return isRemoved;
  }
}
