import 'package:ironbox/src/models/userWorkoutPlanGame.dart';
import 'package:ironbox/src/models/workoutPlanDetails.dart';

class UserWorkoutPlanDetails extends WorkoutPlanDetails {
  String id;
  String originalWOPDetailId;
  String userPlanId;
  int calBurn;
  int avgCal; // user specific
  double progress;
  List<UserWorkoutPlanGame> userGamesList;

  UserWorkoutPlanDetails();

  UserWorkoutPlanDetails.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      originalWOPDetailId = jsonMap['pre_workout_plan_details_id'] != null
          ? jsonMap['pre_workout_plan_details_id']
          : "";
      userPlanId = jsonMap['user_workout_plan_id'] != null
          ? jsonMap['user_workout_plan_id']
          : "";
      weekNumber = jsonMap['week_number'] != null ? jsonMap['week_number'] : "";
      dayNumber = jsonMap['day_number'] != null ? jsonMap['day_number'] : "";
      dayTitle = jsonMap['day_title'] != null ? jsonMap['day_title'] : "";
      calBurn =
          jsonMap['cal_burn'] != null ? int.parse(jsonMap['cal_burn']) : 0;
      avgCal = jsonMap['avg_cal'] != null ? int.parse(jsonMap['avg_cal']) : 0;
      progress =
          jsonMap['progress'] != null ? double.parse(jsonMap['progress']) : 0.0;
      minCal = jsonMap['min_calories'] != null
          ? int.parse(jsonMap['min_calories'])
          : 0;
      maxCal = jsonMap['max_calories'] != null
          ? int.parse(jsonMap['max_calories'])
          : 0;
      userGamesList =
          jsonMap['games'] != null && (jsonMap['games'] as List).length > 0
              ? List.from(jsonMap['games'])
                  .map((element) => UserWorkoutPlanGame.fromJSON(element))
                  .toList()
              : [];
    } catch (e) {
      print("User Workout Plan Details Model Error: $e");
    }
  }
}
