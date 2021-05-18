import 'package:fitness_app/src/models/category.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  var categories = List<Category>().obs;

  HomeController() {
    // listenForStepCount();
  }

  Future<void> checkActivityRecognitionPermission() async {
    Permission activityRecognitionPermission = Permission.activityRecognition;
    PermissionStatus activityRecognitionPermissionStatus =
        await activityRecognitionPermission.status;
    if (activityRecognitionPermissionStatus.isGranted) {
      print("Permission is granted");
    } else if (activityRecognitionPermissionStatus.isUndetermined) {
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
    } else if (bodySensorPermissionStatus.isUndetermined) {
      bodySensorPermissionStatus = await bodySensorPermission.request();
      print("new permission status: ${bodySensorPermissionStatus.isGranted}");
    }
  }

  // Future<void> listenForCategories() async {
  //   print("fetching categories from home controller");
  //   Stream<Category> stream = await categoryRepo.getCategories();

  //   stream.listen((Category _category) {
  //     print(_category.backgroundImgUrl);
  //     categories.add(_category);
  //   }, onError: (a) {
  //     print("Error thrown while getting categories");
  //     print(a);
  //   }, onDone: () {
  //     print("Done fetching categories");
  //   });
  // }
}
