import 'package:intl/intl.dart';
import 'package:ironbox/src/models/category.dart';
import 'package:ironbox/src/models/logs.dart';
import 'package:ironbox/src/repositories/logs_repo.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;
import '../repositories/category_repo.dart' as categoryRepo;

class HomeController extends GetxController {
  var categories = List<Category>().obs;
  var upComingChallenges = List<String>().obs;
  DateFormat _dateFormatter;
  String currentDate;
  var doneFetchingChallenges = false.obs;

  HomeController() {
    // listenForStepCount();
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
    Stream<Category> stream = await categoryRepo.getCategories();

    stream.listen((Category _category) {
      print(_category.backgroundImgUrl);
      categories.add(_category);
    }, onError: (e) {
      print("Error thrown while getting categories: $e");
    }, onDone: () {
      print("Done fetching categories");
    });
  }

  Future<void> refreshHome() async {
    listenForCategories();
    getUpComingChallenges(userRepo.currentUser.value.id, currentDate);
  }
}
