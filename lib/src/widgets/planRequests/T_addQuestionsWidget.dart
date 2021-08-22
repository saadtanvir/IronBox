import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plan_questions_controller.dart';
import 'package:ironbox/src/models/questions.dart';
import 'package:ironbox/src/models/trainerQuestion.dart';
import 'package:ironbox/src/widgets/lists/questionsList.dart';
import 'package:ironbox/src/widgets/lists/trainerQuestionsList.dart';
import '../../repositories/user_repo.dart' as userRepo;
import '../../helpers/app_constants.dart' as Constants;

class TrainerAddPlanQuestionsWidget extends StatefulWidget {
  const TrainerAddPlanQuestionsWidget({Key key}) : super(key: key);

  @override
  _TrainerAddPlanQuestionsWidgetState createState() =>
      _TrainerAddPlanQuestionsWidgetState();
}

class _TrainerAddPlanQuestionsWidgetState
    extends State<TrainerAddPlanQuestionsWidget> {
  PlanQuestionController _con =
      Get.find(tag: Constants.trainerEditCustomPlanQuestions);

  Future<bool> onQuestionAdd(Question question, int isOptional) async {
    bool isAdded = await _con.addQuestionForTrainer(
        questionId: question.id,
        trainerId: userRepo.currentUser.value.id,
        isOptional: isOptional.toString());
    return isAdded;
  }

  @override
  void initState() {
    _con.getAllQuestionsExcludingTrainerQuestions(userRepo.currentUser.value.id,
        userRepo.currentUser.value.specializationCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return _con.planQuestionsList.isEmpty &&
                      !_con.doneFetchingPlanQuestions.value
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: CircularProgressIndicator(),
                    ))
                  : _con.planQuestionsList.isEmpty &&
                          _con.doneFetchingPlanQuestions.value
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Text(
                              "No question found!",
                            ),
                          ),
                        )
                      : QuestionsList(
                          questionsList: _con.planQuestionsList,
                          canAddQuestion: true,
                          canRemoveQuestion: false,
                          addQuestion: onQuestionAdd,
                        );
            }),
          ],
        ),
      ),
    );
  }
}
