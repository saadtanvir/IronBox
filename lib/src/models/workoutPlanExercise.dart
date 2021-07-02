class WorkoutPlanExercise {
  String id;
  String gameId;
  String name;
  String duration;
  String videoUrl;
  String description;
  int reps;

  WorkoutPlanExercise();

  WorkoutPlanExercise.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      gameId = jsonMap['game_id'] != null ? jsonMap['game_id'] : "";
      name = jsonMap['name'] != null ? jsonMap['name'] : "";
      reps = jsonMap['reps'] != null ? int.parse(jsonMap['reps']) : 0;
      duration = jsonMap['duration'] != null ? jsonMap['duration'] : "";
      videoUrl = jsonMap['video_url'] != null ? jsonMap['video_url'] : "";
      description =
          jsonMap['description'] != null ? jsonMap['description'] : "";
    } catch (e) {
      print("Workout Plan Exercise Model Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, String>();
    map['game_id'] = gameId;
    map['name'] = name;
    map['reps'] = reps.toString();
    map['duration'] = duration;
    map['video_url'] = videoUrl;
    map['description'] = description;
    return map;
  }
}
