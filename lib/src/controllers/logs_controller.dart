import 'package:ironbox/src/models/logs.dart';
import 'package:ironbox/src/repositories/logs_repo.dart' as logsRepo;
import 'package:intl/intl.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogsController extends GetxController {
  var getAlert = false.obs;
  Logs newLog = new Logs();
  var doneFetchingLogs = false.obs;
  String calendarSelectedDate =
      DateFormat(Constants.dateStringFormat).format(DateTime.now());
  List<Logs> logs = List<Logs>().obs;

  LogsController() {}

  void getUserLogs(String userId, {String date}) async {
    doneFetchingLogs.value = false;
    logs.clear();
    final Stream<Logs> stream = await logsRepo.getUserLogs(userId, date);

    stream.listen(
      (Logs _log) {
        if (_log.id != null) {
          logs.insert(0, _log);
        }
      },
      onError: (e) {
        print("Logs Controller Error: $e");
      },
      onDone: () {
        print("done fetching logs");
        doneFetchingLogs.value = true;
      },
    );
  }

  void addLog() async {
    // Get.back();
    logsRepo.addLog(newLog).then((log) {
      if (log.id != null && log.id.isNotEmpty) {
        logs.insert(0, log);
        Get.snackbar(
          "Success",
          "Log created successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    }).catchError((e) {
      print("Logs Controller Error: $e");
    }).whenComplete(() {});
  }

  void updateLogStatus({String id, String status}) {
    logsRepo.updateLogStatus(id, status).then((updated) {
      if (updated) {
        getUserLogs(userRepo.currentUser.value.id, date: calendarSelectedDate);
        Get.snackbar(
          "Success",
          "Status updated successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    }).catchError((e) {
      print("Logs Controller Error: $e");
    }).whenComplete(() {});
  }

  void deleteLog(String id) {
    // Get.back();
    logs.clear();
    logsRepo.deleteLog(id).then((deleted) {
      if (deleted) {
        getUserLogs(userRepo.currentUser.value.id, date: calendarSelectedDate);
        Get.snackbar(
          "Success",
          "Deleted successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    }).catchError((e) {
      print("Logs Controller Error: $e");
    }).whenComplete(() {});
  }
}
