import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/planRequest.dart';
import 'package:ironbox/src/pages/createCustomDietPlan.dart';
import 'package:ironbox/src/widgets/listTileWidgets/customQuestionCard.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;

class TrainerPlanRequestDetailsPage extends StatefulWidget {
  final PlanRequest request;
  final Function onAccept;
  final Function onReject;
  final Function onStartMakingPlan;
  const TrainerPlanRequestDetailsPage(
      {Key key,
      @required this.request,
      this.onAccept,
      this.onReject,
      this.onStartMakingPlan})
      : super(key: key);

  @override
  _TrainerPlanRequestDetailsPageState createState() =>
      _TrainerPlanRequestDetailsPageState();
}

class _TrainerPlanRequestDetailsPageState
    extends State<TrainerPlanRequestDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text("Request Details"),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Helper.of(context).getScreenHeight() * 0.40,
                  width: Helper.of(context).getScreenWidth(),
                  padding: EdgeInsets.only(
                    top: 40.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Request Details",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: UserCircularAvatar(
                          imgUrl: widget.request.user.avatar,
                          adjustment: BoxFit.fill,
                          height: 70.0,
                          width: 70.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${widget.request.user.name}",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.request.user.age}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            " | ",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${widget.request.user.gender}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Card(
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        Text(
                          "Injury:",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          widget.request.user.injury.isNotEmpty
                              ? widget.request.user.injury
                              : "None",
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Card(
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Medical Background:",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          widget.request.user.medicalBG.isNotEmpty
                              ? widget.request.user.medicalBG
                              : "None",
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Card(
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Family Medical Background:",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          widget.request.user.familyMedicalBG.isNotEmpty
                              ? widget.request.user.familyMedicalBG
                              : "None",
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                // show question answer widget
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // increase item count by 1
                  // so that separator widget also builds for last builder widget
                  itemCount:
                      widget.request.requestQuestionsAnswersList.length + 1,
                  itemBuilder: (context, index) {
                    // this widget prints from 0 to length - 1
                    print(widget.request.requestQuestionsAnswersList.length);
                    print(index);
                    print("is question null ?");
                    // print(widget.request.requestQuestionsAnswersList[index]
                    //         .trainerQuestion ==
                    //     null);
                    return index <
                            widget.request.requestQuestionsAnswersList.length
                        ? CustomQuestionCard(
                            question: widget
                                .request
                                .requestQuestionsAnswersList[index]
                                .trainerQuestion
                                .originalQuestion,
                            canAdd: false,
                            canRemove: false)
                        : const SizedBox(
                            height: 0.0,
                            width: 0.0,
                          );
                  },
                  separatorBuilder: (context, index) {
                    return index <=
                            widget.request.requestQuestionsAnswersList.length
                        ? Card(
                            color: Colors.grey[300],
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Answer:",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(widget
                                              .request
                                              .requestQuestionsAnswersList[
                                                  index]
                                              .statement
                                              .isNotEmpty ||
                                          widget
                                                  .request
                                                  .requestQuestionsAnswersList[
                                                      index]
                                                  .statement !=
                                              null
                                      ? widget
                                          .request
                                          .requestQuestionsAnswersList[index]
                                          .statement
                                      : "N/A"),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 0.0,
                            width: 0.0,
                          );
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                widget.request.reqStatus == 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () async {
                              // 2 = accepted
                              widget.onAccept(widget.request, "2");
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(horizontal: 15.0),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              overlayColor: MaterialStateProperty.all(
                                Theme.of(context).accentColor.withOpacity(0.3),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            child: Text(
                              "Accept",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                            onPressed: () async {
                              // 3 = rejected
                              widget.onAccept(widget.request, "3");
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(horizontal: 15.0),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              overlayColor: MaterialStateProperty.all(
                                Theme.of(context).accentColor.withOpacity(0.3),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            child: Text(
                              "Reject",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    : widget.request.reqStatus == 2
                        ? Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () async {
                                // to create plan
                                Get.to(
                                  CreateCustomDietPlan(request: widget.request),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                overlayColor: MaterialStateProperty.all(
                                  Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.3),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Create Plan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 0.0,
                            width: 0.0,
                          ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            Positioned(
              top: Helper.of(context).getScreenHeight() * 0.35,
              left: 30.0,
              right: 30.0,
              child: Container(
                width: Helper.of(context).getScreenWidth(),
                constraints: BoxConstraints(
                  minHeight: 70.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber[300],
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.amber,
                  //     spreadRadius: 1,
                  //     blurRadius: 1,
                  //     offset: Offset(2, 0),
                  //   ),
                  // ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${widget.request.user.weight}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Weight",
                        )
                      ],
                    ),
                    Text(
                      "    |    ",
                      style: const TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "${widget.request.user.height}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Height",
                        )
                      ],
                    ),
                    Text(
                      "    |    ",
                      style: const TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          Helper.getUserBMI(widget.request.user.height,
                              widget.request.user.weight),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "BMI",
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Text("data"),
          ],
        ),
      ),
    );
  }
}
