import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/pages/answerQuestionsPage.dart';
import 'package:ironbox/src/widgets/trainerProfileDetails.dart';
import '../helpers/app_constants.dart' as Constants;

class RequestDietPlanScreen extends StatefulWidget {
  final User trainer;
  const RequestDietPlanScreen({Key key, @required this.trainer})
      : super(key: key);

  @override
  _RequestDietPlanScreenState createState() => _RequestDietPlanScreenState();
}

class _RequestDietPlanScreenState extends State<RequestDietPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review Trainer"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TrainerProfileDetailsWidget(trainer: widget.trainer),
            TextButton(
              onPressed: () {
                Get.to(AnswerQuestions(trainer: widget.trainer),
                    transition: Transition.rightToLeft);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20.0),
                ),
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                overlayColor: MaterialStateProperty.all(
                  Theme.of(context).accentColor.withOpacity(0.3),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
              child: Text(
                "Request Custom Diet Plan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
