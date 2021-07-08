import 'package:ironbox/src/models/workoutPlanExercise.dart';

class UserWorkoutPlanExercise extends WorkoutPlanExercise {
  String id;
  // String originalWOPExerciseId;
  String userWOPGameId;
  int status;

  UserWorkoutPlanExercise();

  UserWorkoutPlanExercise.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      userWOPGameId = jsonMap['user_workout_plan_game_id'] != null
          ? jsonMap['user_workout_plan_game_id']
          : "";
      name = jsonMap['name'] != null ? jsonMap['name'] : "";
      reps = jsonMap['reps'] != null ? int.parse(jsonMap['reps']) : 0;
      duration = jsonMap['duration'] != null ? jsonMap['duration'] : "";
      videoUrl = jsonMap['video_url'] != null ? jsonMap['video_url'] : "";
      status = jsonMap['status'] != null
          ? int.parse(jsonMap['status'].toString())
          : 0;
      description =
          jsonMap['description'] != null ? jsonMap['description'] : "";
    } catch (e) {
      print("User Workout Plan Exercise Model Error: $e");
    }
  }
}
