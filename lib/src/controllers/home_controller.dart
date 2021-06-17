import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/category.dart';
import 'package:ironbox/src/models/logs.dart';
import 'package:ironbox/src/repositories/logs_repo.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;
import '../repositories/category_repo.dart' as categoryRepo;

class HomeController extends GetxController {
  var categories = List<Category>().obs;
  var upComingChallenges = List<String>().obs;
  DateFormat _dateFormatter;
  String currentDate;
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  Map<String, dynamic> stepMap = {};
  var steps = 0.obs;
  var doneFetchingChallenges = false.obs;

  HomeController() {
    listenForStepCount();
    checkActivityRecognitionPermission();
    checkBodySensorPermission();
    getChildCategories();
    getSubCategories();
    listenForCategories();
    _dateFormatter = DateFormat(Constants.dateStringFormat);
    currentDate = _dateFormatter.format(DateTime.now());
  }

  Future<void> checkActivityRecognitionPermission() async {
    Permission activityRecognitionPermission = Permission.activityRecognition;
    PermissionStatus activityRecognitionPermissionStatus =
        await activityRecognitionPermission.status;
    if (activityRecognitionPermissionStatus.isGranted) {
      print("Permission is granted");
    } else if (activityRecognitionPermissionStatus.isDenied) {
      activityRecognitionPermissionStatus =
          await activityRecognitionPermission.request();
      print(
          "new permission status: ${activityRecognitionPermissionStatus.isGranted}");
    }
  }

  Future<void> checkBodySensorPermission() async {
    Permission bodySensorPermission = Permission.sensors;
    PermissionStatus bodySensorPermissionStatus =
        await bodySensorPermission.status;
    if (bodySensorPermissionStatus.isGranted) {
      print("Permission is granted");
    } else if (bodySensorPermissionStatus.isDenied) {
      bodySensorPermissionStatus = await bodySensorPermission.request();
      print("new permission status: ${bodySensorPermissionStatus.isGranted}");
    }
  }

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
    stepMap = {"steps": steps, "date": event.timeStamp.toString()};
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

  Future<void> getUpComingChallenges(String userId, String date) async {
    doneFetchingChallenges.value = false;
    upComingChallenges.clear();
    final Stream<Logs> stream = await getUserLogs(userId, date);
    stream.listen((Logs log) {
      print(log.isCompleted);
      if (log.isCompleted == 0) {
        upComingChallenges.add(log.title);
      }
    }, onError: (e) {
      print(e);
    }, onDone: () {
      doneFetchingChallenges.value = true;
    });
  }

  Future<void> listenForCategories() async {
    print("fetching categories from home controller");
    categories.clear();
    Stream<Category> stream = await categoryRepo.getAppCategories();

    stream.listen((Category _category) {
      print(_category.backgroundImgUrl);
      categories.add(_category);
    }, onError: (e) {
      print("Error thrown while getting categories: $e");
    }, onDone: () {
      print("Done fetching categories");
    });
  }

  Future<void> getSubCategories() async {
    Constants.subCategories.clear();
    Stream<Category> stream = await categoryRepo.getSubCategories();

    stream.listen((Category _category) {
      Constants.subCategories.add(_category);
    }).onError((e) {
      print("Error getting subcategories: $e");
    });
  }

  Future<void> getChildCategories() async {
    Constants.childCategories.clear();
    Stream<Category> stream = await categoryRepo.getChildCategories();

    stream.listen((Category _category) {
      Constants.childCategories.add(_category);
    }).onError((e) {
      print("Error getting child categories: $e");
    });
  }

  Future<void> refreshHome() async {
    getChildCategories();
    getSubCategories();
    listenForCategories();
    getUpComingChallenges(userRepo.currentUser.value.id, currentDate);
  }
}
