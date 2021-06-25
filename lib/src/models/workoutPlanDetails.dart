import 'package:ironbox/src/models/workoutPlanGame.dart';

class WorkoutPlanDetails {
  String id;
  String planId;
  String dayTitle;
  String dayNumber;
  String weekNumber;
  int minCal;
  int maxCal;
  List<WorkoutPlanGame> gamesList;

  WorkoutPlanDetails();

  WorkoutPlanDetails.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      planId = jsonMap['plan_id'] != null ? jsonMap['plan_id'] : "";
      weekNumber = jsonMap['week_number'] != null ? jsonMap['week_number'] : "";
      dayNumber = jsonMap['day_number'] != null ? jsonMap['day_number'] : "";
      dayTitle = jsonMap['day_title'] != null ? jsonMap['day_title'] : "";
      minCal = jsonMap['min_calories'] != null
          ? int.parse(jsonMap['min_calories'])
          : 0;
      maxCal = jsonMap['max_calories'] != null
          ? int.parse(jsonMap['max_calories'])
          : 0;
      gamesList =
          jsonMap['games'] != null && (jsonMap['games'] as List).length > 0
              ? WorkoutPlanGame.fromJSON(jsonMap['games'])
              : [];
    } catch (e) {
      print("Workout Plan Details Model Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, String>();
    map['plan_id'] = planId;
    map['day_title'] = dayTitle;
    map['min_calories'] = minCal.toString();
    map['max_calories'] = maxCal.toString();
    map['day_number'] = dayNumber;
    map['week_number'] = weekNumber;
    return map;
  }
}
