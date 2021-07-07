import 'dart:async';

import 'package:ironbox/src/models/category.dart';
import 'package:ironbox/src/models/userWorkoutPlanDetails.dart';
import 'package:ironbox/src/models/workoutPlan.dart';
import 'package:ironbox/src/models/workoutPlanDetails.dart';
import 'package:ironbox/src/widgets/circularProgressIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../helpers/app_constants.dart' as Constants;

class Helper {
  BuildContext context;
  DateTime currentBackPressTime;

  // Helper();
  Helper.of(BuildContext _context) {
    this.context = _context;
  }

  double getScreenHeight() {
    return MediaQuery.of(context).size.height;
  }

  double getScreenWidth() {
    return MediaQuery.of(context).size.width;
  }

  TextStyle textStyle(
      {double size = 15.0,
      Color color = Constants.primaryTextColor,
      double colorOpacity = 1.0,
      FontWeight font = FontWeight.normal}) {
    if (colorOpacity >= 0.0 && colorOpacity <= 1.0) {
      return TextStyle(
          color: color.withOpacity(colorOpacity),
          fontSize: size,
          fontWeight: font);
    } else {
      print("StackTrace: Color opacity value is out of range!");
      return TextStyle(
          color: color.withOpacity(1.0), fontSize: size, fontWeight: font);
    }
  }

  static RegExp passwordRegExp() {
    return new RegExp(r'[_!@#$%^&*(),.?":{}|<>]');
  }

  static RegExp youtubeUrlRegExp() {
    return new RegExp(r"^(https?\:\/\/)?(www|m\.youtube\.com|youtu\.?be)\/.+$");
  }

  static FocusNode getFocusNode() {
    FocusNode fn = new FocusNode();
    return fn;
  }

  // for mapping data retrieved form json array
  static getData(Map<String, dynamic> data) {
    return data['data'] ?? [];
  }

  static Uri getUri(String path) {
    String _path = Uri.parse(GlobalConfiguration().get("api_base_url")).path;
    if (!_path.endsWith('/')) {
      _path += '/';
    }
    Uri uri = Uri(
        scheme: Uri.parse(GlobalConfiguration().get("api_base_url")).scheme,
        host: Uri.parse(GlobalConfiguration().get("api_base_url")).host,
        port: Uri.parse(GlobalConfiguration().get("api_base_url")).port,
        path: _path + path);
    return uri;
  }

  // remove new line '\n' from string
  static String trimNewLine(String input) {
    String result = "";
    if (!input.contains('\n')) {
      return input;
    } else {
      for (int i = 0; i < input.length; i++) {
        if (input[i] != '\n') {
          result += input[i];
        }
      }
      return result;
    }
  }

  static BorderRadius senderMessageBoxRadius() {
    return BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
        bottomLeft: Radius.circular(15.0));
  }

  static BorderRadius receiverMessageBoxRadius() {
    return BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
        bottomRight: Radius.circular(15.0));
  }

  // return 12hr time from Datetime
  static String get12hrTime(DateTime now) {
    String formattedTime = DateFormat.jm().format(now);
    return formattedTime;
  }

  static String getMessageTime(DateTime messageTime) {
    int differenceInDay = DateTime.now().difference(messageTime).inDays;
    String timeWithMonthDay = DateFormat.MMMMd().format(messageTime);
    String formattedTime = DateFormat.jm().format(messageTime);
    String monthDayTime = "$timeWithMonthDay $formattedTime";

    return differenceInDay > 0 ? monthDayTime : formattedTime;
  }

  static int calculateTodaySteps(
      int totalSteps, int lastCountedSteps, DateTime lastRecordedDate) {
    int todaySteps;
    int differenceInDays = DateTime.now().difference(lastRecordedDate).inDays;
    if (differenceInDays >= 1) {
      if (totalSteps > lastCountedSteps) {
        todaySteps = totalSteps - lastCountedSteps;
        print("returning today's steps");
        return todaySteps;
      } else {
        return lastCountedSteps;
      }
    } else {
      return lastCountedSteps;
    }
  }

  static List<Category> getSpecificSubCategories(String appCategoryId) {
    List<Category> specificCategoryList = [];
    Constants.subCategories.forEach((category) {
      if (category.parentId == appCategoryId) {
        specificCategoryList.add(category);
      }
    });
    return specificCategoryList;
  }

  static String getMainCategoryId(String mainCategoryName) {
    String mainCategoryId = "";
    Constants.appCategories.forEach((category) {
      if (category.name == mainCategoryName) {
        mainCategoryId = category.id;
      }
    });
    return mainCategoryId;
  }

  static List<Category> getSpecificChildCategories(String id) {
    List<Category> specificCategoryList = [];
    Constants.childCategories.forEach((category) {
      if (category.parentId == id) {
        specificCategoryList.add(category);
      }
    });
    return specificCategoryList;
  }

  static String getYoutubeVideoThumbnailUrl({
    @required String videoId,
    String quality = ThumbnailQuality.standard,
    bool webp = false,
  }) {
    return webp
        ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp'
        : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';
  }

  static WorkoutPlanDetails getWOPSingleDayDetails(
      {@required List<WorkoutPlanDetails> planDetailsList,
      @required String weekNum,
      @required String dayNum}) {
    WorkoutPlanDetails singleDayDetail;
    planDetailsList.forEach((WorkoutPlanDetails detail) {
      if (detail.weekNumber == weekNum && detail.dayNumber == dayNum) {
        print("details found");
        singleDayDetail = detail;
      } else {
        print("details not found");
        singleDayDetail = new WorkoutPlanDetails();
      }
    });
    return singleDayDetail;
  }

  static UserWorkoutPlanDetails getUserWOPSingleDayDetails(
      {@required List<UserWorkoutPlanDetails> planDetailsList,
      @required String weekNum,
      @required String dayNum}) {
    UserWorkoutPlanDetails singleDayDetail;
    planDetailsList.forEach((UserWorkoutPlanDetails detail) {
      if (detail.weekNumber == weekNum && detail.dayNumber == dayNum) {
        print("details found");
        singleDayDetail = detail;
      } else {
        print("details not found");
        singleDayDetail = new UserWorkoutPlanDetails();
      }
    });
    return singleDayDetail;
  }

  static int calAvgCal({@required int minCal, @required int maxCal}) {
    double avg = (minCal + maxCal) / 2;
    return avg.toInt();
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          // set opacity of color to make
          // background screen blur type
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          child: CustomCircularProgressIndicator(height: 200),
        ),
      );
    });
    return loader;
  }

  static hideLoader(OverlayEntry loader) {
    Timer(Duration(milliseconds: 500), () {
      try {
        loader?.remove();
      } catch (e) {}
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      // Fluttertoast.showToast(msg: "Tap again to leave");
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}
