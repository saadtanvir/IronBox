import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plan_questions_controller.dart';
import 'package:ironbox/src/widgets/lists/questionsList.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;

class TrainerEditPlanQuestions extends StatefulWidget {
  const TrainerEditPlanQuestions({Key key}) : super(key: key);

  @override
  _TrainerEditPlanQuestionsState createState() =>
      _TrainerEditPlanQuestionsState();
}

class _TrainerEditPlanQuestionsState extends State<TrainerEditPlanQuestions> {
  PlanQuestionController _con = Get.put(PlanQuestionController());

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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Obx((){
            //   return _con.trainerQuestions.isEmpty && !_con.doneFetchingQuestions.value ? Center(child: CircularProgressIndicator(),) : _con.trainerQuestions.isEmpty && _con.doneFetchingQuestions.value ? Center(child: Text("No question added!"),) :
            // }),
          ],
        ),
      ),
    );
  }
}
