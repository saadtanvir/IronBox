import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import '../../helpers/app_constants.dart' as Constants;

class AddWorkoutPlanDayDetails extends StatefulWidget {
  final String planId;
  final int weekNum;
  final int dayNum;
  AddWorkoutPlanDayDetails(
      {Key key,
      @required this.dayNum,
      @required this.planId,
      @required this.weekNum})
      : super(key: key);

  @override
  _AddWorkoutPlanDayDetailsState createState() =>
      _AddWorkoutPlanDayDetailsState();
}

class _AddWorkoutPlanDayDetailsState extends State<AddWorkoutPlanDayDetails> {
  PlansController _con = Get.find(tag: Constants.createWorkoutPlanController);
  GlobalKey<FormState> _workoutPlanDayDetailsFormKey;

  @override
  void initState() {
    // get plan details
    _con.getWorkoutPlanDetails(
        planId: widget.planId, weekNum: widget.weekNum, dayNum: widget.dayNum);
    _workoutPlanDayDetailsFormKey = new GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Day Details"),
        centerTitle: true,
      ),
      body: Obx(() {
        return !_con.doneFetchingWorkoutPlanDetails.value
            ? const Center(
                child: const CircularProgressIndicator(),
              )
            : _con.doneFetchingWorkoutPlanDetails.value
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: _workoutPlanDayDetailsFormKey,
                        child: SingleChildScrollView(
                          child: _con.workoutPlanDetails.id == null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Constants.title + ":",
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 0.0,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      onSaved: (input) => _con
                                          .workoutPlanDetails.dayTitle = input,
                                      validator: (input) =>
                                          input.length < 1 ? "required" : null,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        hintText: Constants.shoulder_and_legs,
                                        hintStyle: TextStyle(
                                          fontSize: 12.0,
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.3),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50.0,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Constants.min_calories_burn +
                                                    ":",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 0.0,
                                              ),
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                onSaved: (input) => _con
                                                    .workoutPlanDetails
                                                    .minCal = int.parse(input),
                                                validator: (input) =>
                                                    input.length < 1
                                                        ? "required"
                                                        : null,
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  hintText: "300",
                                                  hintStyle: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Theme.of(context)
                                                        .accentColor
                                                        .withOpacity(0.3),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Constants.max_calories_burn +
                                                    ":",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 0.0,
                                              ),
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                onSaved: (input) => _con
                                                    .workoutPlanDetails
                                                    .maxCal = int.parse(input),
                                                validator: (input) =>
                                                    input.length < 1
                                                        ? "required"
                                                        : null,
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  hintText: "400",
                                                  hintStyle: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Theme.of(context)
                                                        .accentColor
                                                        .withOpacity(0.3),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        onPressed: () async {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          if (!_workoutPlanDayDetailsFormKey
                                              .currentState
                                              .validate()) {
                                            return;
                                          } else if (_workoutPlanDayDetailsFormKey
                                              .currentState
                                              .validate()) {
                                            _workoutPlanDayDetailsFormKey
                                                .currentState
                                                .save();
                                            _con.workoutPlanDetails.dayNumber =
                                                widget.dayNum.toString();
                                            _con.workoutPlanDetails.planId =
                                                widget.planId;
                                            _con.workoutPlanDetails.weekNumber =
                                                widget.weekNum.toString();
                                            _con.createWorkoutPlanDetails(
                                                context);
                                          }
                                        },
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                            Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.3),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          Constants.next,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Constants.title + ":",
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 0.0,
                                    ),
                                    TextFormField(
                                      initialValue:
                                          _con.workoutPlanDetails.dayTitle,
                                      keyboardType: TextInputType.text,
                                      onSaved: (input) => _con
                                          .workoutPlanDetails.dayTitle = input,
                                      validator: (input) =>
                                          input.length < 1 ? "required" : null,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        hintText: Constants.shoulder_and_legs,
                                        hintStyle: TextStyle(
                                          fontSize: 12.0,
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.3),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50.0,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Constants.min_calories_burn +
                                                    ":",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 0.0,
                                              ),
                                              TextFormField(
                                                initialValue: _con
                                                    .workoutPlanDetails.minCal
                                                    .toString(),
                                                keyboardType:
                                                    TextInputType.number,
                                                onSaved: (input) => _con
                                                    .workoutPlanDetails
                                                    .minCal = int.parse(input),
                                                validator: (input) =>
                                                    input.length < 1
                                                        ? "required"
                                                        : null,
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  hintText: "300",
                                                  hintStyle: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Theme.of(context)
                                                        .accentColor
                                                        .withOpacity(0.3),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Constants.max_calories_burn +
                                                    ":",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 0.0,
                                              ),
                                              TextFormField(
                                                initialValue: _con
                                                    .workoutPlanDetails.maxCal
                                                    .toString(),
                                                keyboardType:
                                                    TextInputType.number,
                                                onSaved: (input) => _con
                                                    .workoutPlanDetails
                                                    .maxCal = int.parse(input),
                                                validator: (input) =>
                                                    input.length < 1
                                                        ? "required"
                                                        : null,
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  hintText: "400",
                                                  hintStyle: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Theme.of(context)
                                                        .accentColor
                                                        .withOpacity(0.3),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        onPressed: () async {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          if (!_workoutPlanDayDetailsFormKey
                                              .currentState
                                              .validate()) {
                                            return;
                                          } else if (_workoutPlanDayDetailsFormKey
                                              .currentState
                                              .validate()) {
                                            _workoutPlanDayDetailsFormKey
                                                .currentState
                                                .save();
                                            // _con.workoutPlanDetails.dayNumber =
                                            //     widget.dayNum.toString();
                                            // _con.workoutPlanDetails.planId =
                                            //     widget.planId;
                                            // _con.workoutPlanDetails.weekNumber =
                                            //     widget.weekNum.toString();
                                            _con.updateWorkoutPlanDetails(
                                                context);
                                          }
                                        },
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                            Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.3),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          Constants.next,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0.0,
                  );
      }),
    );
  }
}
