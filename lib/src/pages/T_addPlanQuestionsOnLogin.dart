import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plan_questions_controller.dart';
import 'package:ironbox/src/widgets/lists/questionsList.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;

class TrainerAddPlanQuestionsOnLogin extends StatefulWidget {
  final int questionsCategory; // specialisation category of trainer
  final int accountStatus;
  const TrainerAddPlanQuestionsOnLogin(
      this.questionsCategory, this.accountStatus,
      {Key key})
      : super(key: key);

  @override
  _TrainerAddPlanQuestionsOnLoginState createState() =>
      _TrainerAddPlanQuestionsOnLoginState();
}

class _TrainerAddPlanQuestionsOnLoginState
    extends State<TrainerAddPlanQuestionsOnLogin> {
  // make question answer controller
  // fetch all category questions
  // add and delete questions
  PlanQuestionController _con = Get.put(PlanQuestionController());
  var questionAddedCount = 0.obs;

  Future<bool> addQuestion(String questionId, int isOptional) async {
    bool isAdded = await _con.addQuestionForTrainer(
        questionId: questionId,
        trainerId: userRepo.currentUser.value.id,
        isOptional: isOptional.toString());
    questionAddedCount.value =
        isAdded ? questionAddedCount.value + 1 : questionAddedCount.value;
    return isAdded;
  }

  Future<bool> removeQuestion(String questionId) async {
    // remove question
    // decrease count
    bool isRemoved = await _con.removeQuestionFromTrainer(
        userRepo.currentUser.value.id, questionId);
    questionAddedCount.value =
        isRemoved ? questionAddedCount.value - 1 : questionAddedCount.value;
    return isRemoved;
  }

  @override
  void initState() {
    _con.getQuestions(widget.questionsCategory.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 10.0),
              child: TextButton(
                onPressed: () {
                  if (widget.accountStatus == 1) {
                    Get.offAllNamed('/TrainerBtmNavBar');
                  } else {
                    Get.offAllNamed('/TrainerUnApprovedAccount');
                  }
                },
                child: Obx(() {
                  return questionAddedCount.value == 0
                      ? Text(
                          "Skip",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox(
                          height: 0.0,
                          width: 0.0,
                        );
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "${Constants.select_questions_to_be_answered}",
            ),
          ),
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
                        child: Text(
                          "No question to add",
                        ),
                      )
                    : QuestionsList(
                        questionsList: _con.planQuestionsList,
                        canAddQuestion: true,
                        canRemoveQuestion: true,
                        addQuestion: addQuestion,
                        removeQuestion: removeQuestion,
                      );
          }),
          // SizedBox(height: 50.0,),
          Align(
            alignment: Alignment.center,
            child: Obx(() {
              return TextButton(
                onPressed: () async {
                  // now go on next screen
                  if (questionAddedCount.value > 0) {
                    if (widget.accountStatus == 1) {
                      Get.offAllNamed('/TrainerBtmNavBar');
                    } else {
                      Get.offAllNamed('/TrainerUnApprovedAccount');
                    }
                  }
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  backgroundColor: questionAddedCount.value > 0
                      ? MaterialStateProperty.all(
                          Theme.of(context).primaryColor)
                      : MaterialStateProperty.all(
                          Theme.of(context).primaryColor.withOpacity(0.7)),
                  overlayColor: MaterialStateProperty.all(
                    Theme.of(context).accentColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                child: Text(
                  "Done",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ));
  }
}
