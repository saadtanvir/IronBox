import 'dart:convert';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:ironbox/src/repositories/user_repo.dart' as userRepo;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:health/health.dart';

class UserDetailsCardWidget extends StatefulWidget {
  @override
  _UserDetailsCardWidgetState createState() => _UserDetailsCardWidgetState();
}

class _UserDetailsCardWidgetState extends State<UserDetailsCardWidget> {
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  Map<String, dynamic> stepMap = {};
  var steps = 0.obs;
  bool accessAuthorization1 = true;

  // counting steps
  void listenForStepCount() async {
    // add permissions for ios
    // in info p list
    // if step count is not accurate
    // follow below link
    // https://blog.maskys.com/implementing-a-daily-step-count-pedometer-in-flutter/
    print("listening for step count");
    _stepCountStream = await Pedometer.stepCountStream;
    _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
    _stepCountStream.listen(_getTodaySteps).onError(_onError);
    _pedestrianStatusStream
        .listen(_onPedestrianStatusChanged)
        .onError(_onPedestrianStatusError);
  }

  void _onDone() => print("Finished pedometer tracking");
  void _onError(error) => print("Pedometer Error: $error");
  void _getTodaySteps(StepCount event) async {
    // This is where we'll write our logic
    print("Total steps");
    print(event.steps);
    print(event.timeStamp.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("steps")) {
      var lastCountedSteps = json.decode(await prefs.get("steps"));
      print("last recorded date: ${lastCountedSteps["date"]}");
      print("last known steps: ${lastCountedSteps["steps"]}");
      steps.value = Helper.calculateTodaySteps(event.steps,
          lastCountedSteps["steps"], DateTime.parse(lastCountedSteps["date"]));
    } else {
      steps.value = event.steps;
    }
    stepMap = {"steps": steps.value, "date": event.timeStamp.toString()};
    await prefs.setString("steps", json.encode(stepMap));
  }

  void _onPedestrianStatusChanged(PedestrianStatus event) {
    /// Handle status changed
    String status = event.status;
    DateTime timeStamp = event.timeStamp;
    print("pedestrian status: ${event.status}");
  }

  void _onPedestrianStatusError(error) {
    /// Handle the error
  }

  void fetchHealthData() async {
    try {
      HealthFactory healthFactory = new HealthFactory();

      // Define the types to get.
      List<HealthDataType> types = [
        HealthDataType.STEPS,
      ];
      bool accessAuthorization =
          await healthFactory.requestAuthorization(types).catchError((e) {
        print(e.toString());
      });
      setState(() {
        accessAuthorization1 = accessAuthorization;
      });
      print(accessAuthorization);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    listenForStepCount();
    // fetchHealthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: Helper.of(context).getScreenWidth(),
      child: Card(
        margin: EdgeInsets.zero,
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 2,
                    child: UserCircularAvatar(80.0, 80.0,
                        "${userRepo.currentUser.value.avatar}", BoxFit.fill),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${userRepo.currentUser.value.name}",
                          style: Helper.of(context).textStyle(size: 20.0),
                        ),
                        Text(
                          "$accessAuthorization1",
                          style: Helper.of(context).textStyle(size: 20.0),
                        )
                        // SizedBox(
                        //   height: 5.0,
                        // ),
                        // Text(
                        //   "Lahore, Pakistan",
                        //   overflow: TextOverflow.ellipsis,
                        //   style: Helper.of(context)
                        //       .textStyle(size: 18.0, colorOpacity: 0.9),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "Summary",
                  style: Helper.of(context)
                      .textStyle(size: 20.0, font: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    percent: 0.7,
                    startAngle: 85.0,
                    radius: 80.0,
                    lineWidth: 2.0,
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(0.5),
                    progressColor: Constants.scaffoldColor.withOpacity(0.8),
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return Text(
                            "${steps.value}",
                            overflow: TextOverflow.ellipsis,
                            style: Helper.of(context)
                                .textStyle(size: 12.0, font: FontWeight.bold),
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_walk,
                              size: 10.0,
                              color: Constants.scaffoldColor,
                            ),
                            Text(
                              "STEPS",
                              style: Helper.of(context).textStyle(size: 10.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  CircularPercentIndicator(
                    percent: 0.7,
                    startAngle: 85.0,
                    radius: 80.0,
                    lineWidth: 2.0,
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(0.5),
                    progressColor: Constants.scaffoldColor.withOpacity(0.8),
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "6h 21m",
                          style: Helper.of(context)
                              .textStyle(size: 12.0, font: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.nightlight_round,
                              size: 10.0,
                              color: Constants.scaffoldColor,
                            ),
                            Text(
                              "SLEEP",
                              style: Helper.of(context).textStyle(size: 10.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  CircularPercentIndicator(
                    percent: 0.7,
                    startAngle: 85.0,
                    radius: 80.0,
                    lineWidth: 2.0,
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(0.5),
                    progressColor: Constants.scaffoldColor.withOpacity(0.8),
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${userRepo.currentUser.value.workout}m",
                          style: Helper.of(context)
                              .textStyle(size: 12.0, font: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fitness_center,
                              size: 10.0,
                              color: Constants.scaffoldColor,
                            ),
                            Text(
                              "WORKOUT",
                              style: Helper.of(context).textStyle(size: 10.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Welcome ${userRepo.currentUser.value.name}",
                    style: Helper.of(context)
                        .textStyle(size: 20.0, font: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
