import 'package:ironbox/src/models/workoutPlanExercise.dart';

class WorkoutPlanGame {
  String id;
  String detailsId;
  String name;
  int sets;
  int rounds;
  List<WorkoutPlanExercise> exercisesList;

  WorkoutPlanGame();

  WorkoutPlanGame.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      detailsId = jsonMap['workout_plan_details_id'] != null
          ? jsonMap['workout_plan_details_id']
          : "";
      name = jsonMap['name'] != null && jsonMap['name'] != "null"
          ? jsonMap['name']
          : "";
      sets = jsonMap['sets'] != null && jsonMap['sets'] != "null"
          ? int.parse(jsonMap['sets'])
          : 0;
      rounds = jsonMap['rounds'] != null && jsonMap['rounds'] != "null"
          ? int.parse(jsonMap['rounds'])
          : 0;
      exercisesList = jsonMap['exercises'] != null &&
              (jsonMap['exercises'] as List).length > 0
          ? List.from(jsonMap['exercises'])
              .map((element) => WorkoutPlanExercise.fromJSON(element))
              .toList()
          : [];
    } catch (e) {
      print("Workout Plan Game Model Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, String>();
    map['workout_plan_details_id'] = detailsId;
    map['name'] = name;
    map['sets'] = sets.toString();
    map['rounds'] = rounds.toString();
    return map;
  }
}
