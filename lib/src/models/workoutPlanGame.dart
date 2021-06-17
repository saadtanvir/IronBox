import 'package:ironbox/src/models/workoutPlanExercise.dart';

class WorkoutPlanGame {
  String id;
  String detailsId;
  String name;
  String sets;
  String rounds;
  List<WorkoutPlanExercise> exercisesList;

  WorkoutPlanGame();

  WorkoutPlanGame.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap[''] != null ? jsonMap[''] : "";
      detailsId = jsonMap['workout_plan_details_id'] != null
          ? jsonMap['workout_plan_details_id']
          : "";
      name = jsonMap['name'] != null ? jsonMap['name'] : "";
      sets = jsonMap['sets'] != null ? jsonMap['sets'] : "";
      rounds = jsonMap['rounds'] != null ? jsonMap['rounds'] : "";
      exercisesList = jsonMap['exercises'] != null &&
              (jsonMap['exercises'] as List).length > 0
          ? WorkoutPlanExercise.fromJSON(jsonMap['exercises'])
          : [];
    } catch (e) {
      print("Workout Plan Game Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, String>();
    map['workout_plan_details_id'] = detailsId;
    map['name'] = name;
    map['sets'] = sets;
    map['rounds'] = rounds;
    return map;
  }
}
