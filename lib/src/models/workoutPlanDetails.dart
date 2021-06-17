import 'package:ironbox/src/models/workoutPlanGame.dart';

class WorkoutPlanDetails {
  String id;
  String planId;
  String dayTitle;
  String minCal;
  String maxCal;
  String dayNumber;
  String weekNumber;
  List<WorkoutPlanGame> gamesList;

  WorkoutPlanDetails();

  WorkoutPlanDetails.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'] : "";
      planId = jsonMap['plan_id'] != null ? jsonMap['plan_id'] : "";
      weekNumber = jsonMap['week_number'] != null ? jsonMap['week_number'] : "";
      dayNumber = jsonMap['day_number'] != null ? jsonMap['day_number'] : "";
      dayTitle = jsonMap['day_title'] != null ? jsonMap['day_title'] : "";
      minCal = jsonMap['min_calories'] != null ? jsonMap['min_calories'] : "";
      maxCal = jsonMap['max_calories'] != null ? jsonMap['max_calories'] : "";
      gamesList =
          jsonMap['games'] != null && (jsonMap['games'] as List).length > 0
              ? WorkoutPlanGame.fromJSON(jsonMap['games'])
              : [];
    } catch (e) {
      print("Workout Plan Details Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, String>();
    map['plan_id'] = planId;
    map['day_title'] = dayTitle;
    map['min_calories'] = minCal;
    map['max_calories'] = maxCal;
    map['day_number'] = dayNumber;
    map['week_number'] = weekNumber;
    return map;
  }
}
