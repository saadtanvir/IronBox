import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plan_questions_controller.dart';
import 'package:ironbox/src/models/trainerQuestion.dart';
import 'package:ironbox/src/widgets/lists/trainerQuestionsList.dart';
import 'package:ironbox/src/widgets/planRequests/T_addQuestionsWidget.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;

class TrainerEditPlanQuestions extends StatefulWidget {
  const TrainerEditPlanQuestions({Key key}) : super(key: key);

  @override
  _TrainerEditPlanQuestionsState createState() =>
      _TrainerEditPlanQuestionsState();
}

class _TrainerEditPlanQuestionsState extends State<TrainerEditPlanQuestions> {
  PlanQuestionController _con = Get.put(PlanQuestionController(),
      tag: Constants.trainerEditCustomPlanQuestions);

  void onTrainerQuestionRemove(TrainerQuestion question) async {
    bool isDeleted =
        await _con.deleteTrainerQuestionFromTrainerTable(question.id);
    if (isDeleted) {
      _con.trainerQuestions.removeWhere((element) {
        return element.id == question.id;
      });
      Fluttertoast.showToast(
          msg: "Question Removed", backgroundColor: Colors.grey[600]);
    } else {
      Get.snackbar("Failed!", Constants.check_internet_connection);
    }
  }

  @override
  void initState() {
    _con.getTrainerQuestions(userRepo.currentUser.value.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                TrainerAddPlanQuestionsWidget(),
                fullscreenDialog: true,
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Obx(() {
          return _con.trainerQuestions.isEmpty &&
                  !_con.doneFetchingQuestions.value
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : _con.trainerQuestions.isEmpty &&
                      _con.doneFetchingQuestions.value
                  ? Center(
                      child: Text("No question added!"),
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        return _con
                            .getTrainerQuestions(userRepo.currentUser.value.id);
                      },
                      child: TrainerQuestionsList(
                        trainerQuestionsList: _con.trainerQuestions,
                        canAdd: false,
                        canRemove: true,
                        onRemove: onTrainerQuestionRemove,
                      ),
                    );
        }),
      ),
    );
  }
}
