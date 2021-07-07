import 'package:ironbox/src/models/userWorkoutPlanExercise.dart';
import 'package:ironbox/src/models/workoutPlanGame.dart';

class UserWorkoutPlanGame extends WorkoutPlanGame {
  String id;
  String originalWOPGameId;
  String userWOPDetailId;
  double progress;
  List<UserWorkoutPlanExercise> exercises;

  UserWorkoutPlanGame();

  UserWorkoutPlanGame.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      originalWOPGameId = jsonMap['pre_workout_plan_games_id'] != null
          ? jsonMap['pre_workout_plan_games_id']
          : "";
      userWOPDetailId = jsonMap['user_workout_plan_details_id'] != null
          ? jsonMap['user_workout_plan_details_id']
          : "";
      progress =
          jsonMap['progress'] != null ? double.parse(jsonMap['progress']) : 0.0;
      name = jsonMap['name'] != null && jsonMap['name'] != "null"
          ? jsonMap['name']
          : "";
      sets = jsonMap['sets'] != null && jsonMap['sets'] != "null"
          ? int.parse(jsonMap['sets'])
          : 0;
      rounds = jsonMap['rounds'] != null && jsonMap['rounds'] != "null"
          ? int.parse(jsonMap['rounds'])
          : 0;
      exercises = jsonMap['exercises'] != null &&
              (jsonMap['exercises'] as List).length > 0
          ? List.from(jsonMap['exercises'])
              .map((element) => UserWorkoutPlanExercise.fromJSON(element))
              .toList()
          : [];
    } catch (e) {
      print("User Workout Plan Game Model Error: $e");
    }
  }
}
