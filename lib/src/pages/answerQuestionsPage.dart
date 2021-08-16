import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plan_questions_controller.dart';
import 'package:ironbox/src/models/questions.dart';
import 'package:ironbox/src/models/requestQuestionAnswer.dart';
import 'package:ironbox/src/widgets/listTileWidgets/customQuestionCard.dart';
import '../models/user.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
import 'package:intl/intl.dart';

class AnswerQuestions extends StatefulWidget {
  final User trainer;
  const AnswerQuestions({Key key, @required this.trainer}) : super(key: key);

  @override
  _AnswerQuestionsState createState() => _AnswerQuestionsState();
}

class _AnswerQuestionsState extends State<AnswerQuestions> {
  PlanQuestionController _con = Get.put(PlanQuestionController());
  GlobalKey<FormState> _questionAnswerFormKey = new GlobalKey<FormState>();

  List<Map> answers = new List();

  DateFormat _dateFormatter = DateFormat(Constants.dateStringFormat);

  @override
  void initState() {
    _con.getTrainerQuestions(widget.trainer.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Request Form"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  "Answer the following questions to submit your request",
                ),
              ),
              Obx(() {
                return _con.trainerQuestions.isEmpty &&
                        !_con.doneFetchingQuestions.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : _con.trainerQuestions.isEmpty &&
                            _con.doneFetchingQuestions.value
                        ? Center(
                            child: const SizedBox(
                              height: 0.0,
                              width: 0.0,
                            ),
                          )
                        : Form(
                            key: _questionAnswerFormKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.separated(
                                    itemCount: _con.trainerQuestions.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return CustomQuestionCard(
                                          question: _con.trainerQuestions[index]
                                              .originalQuestion,
                                          canAdd: false,
                                          canRemove: false);
                                    },
                                    separatorBuilder: (context, index) {
                                      // Question question = _con.trainerQuestions[index].question;
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          onSaved: (input) {
                                            RequestQuestionAnswer answer =
                                                new RequestQuestionAnswer();
                                            answer.statement = input;
                                            answer.trainerQuestionId =
                                                _con.trainerQuestions[index].id;
                                            answers.add(answer.toMap());
                                          },
                                          validator: (input) {
                                            if (!_con.trainerQuestions[index]
                                                    .isOptional &&
                                                input.isEmpty) {
                                              return "Required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Answer",
                                            // floatingLabelBehavior:
                                            //     FloatingLabelBehavior.never,
                                            labelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor,
                                                fontWeight: FontWeight.bold),
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2.0,
                                                  color: Theme.of(context)
                                                      .accentColor
                                                      .withOpacity(0.2)),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
              }),
              const SizedBox(
                height: 10.0,
              ),
              TextButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if (!_questionAnswerFormKey.currentState.validate()) {
                    return;
                  } else {
                    _questionAnswerFormKey.currentState.save();
                    _con.planRequest.category = 2;
                    _con.planRequest.dateRequested =
                        _dateFormatter.format(DateTime.now());
                    _con.planRequest.paymentStatus = 1; // decide after payment
                    _con.planRequest.price = double.parse(widget.trainer.price);
                    _con.planRequest.reqStatus = 1;
                    _con.planRequest.traineeId = userRepo.currentUser.value.id;
                    _con.planRequest.trainerId = widget.trainer.id;
                    // make payment
                    // show confirmation dialog for payment confirmation
                    // call submit req func from payment func
                    _con.submitPlanRequest(context, answers);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
