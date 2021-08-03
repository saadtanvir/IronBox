import 'package:ironbox/src/models/userWorkoutPlanDetails.dart';
import 'package:ironbox/src/models/workoutPlan.dart';

class UserWorkoutPlan extends WorkoutPlan {
  String id;
  String uid;
  String originalPid;
  String version;
  double progress;
  int reviewStatus; // 0 = not yet reviewed, 1 = reviewed
  List<UserWorkoutPlanDetails> detailsList;

  UserWorkoutPlan();

  UserWorkoutPlan.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      uid = jsonMap['user_id'] != null ? jsonMap['user_id'].toString() : "";
      originalPid =
          jsonMap['plan_id'] != null ? jsonMap['plan_id'].toString() : "";
      progress =
          jsonMap['progress'] != null ? double.parse(jsonMap['progress']) : 0.0;
      title = jsonMap['title'] != null ? jsonMap['title'] : "";
      description =
          jsonMap['description'] != null ? jsonMap['description'] : "";
      caution = jsonMap['caution'] != null ? jsonMap['caution'] : "";
      trainerId = jsonMap['trainer_id'] != null ? jsonMap['trainer_id'] : "";
      coverImg = jsonMap['cover_img'] != null ? jsonMap['cover_img'] : "";
      videoUrl = jsonMap['cover_video'] != null ? jsonMap['cover_video'] : "";
      muscleType = jsonMap['muscle_type'] != null ? jsonMap['muscle_type'] : "";
      categoryId = jsonMap['category'] != null ? jsonMap['category'] : "";
      version = jsonMap['version'] != null ? jsonMap['version'] : "";
      reviewStatus = jsonMap['review_status'] != null
          ? int.parse(jsonMap['review_status'])
          : "";
      status = jsonMap['status'] != null
          ? int.parse(jsonMap['status'].toString())
          : 0;
      durationInWeeks = jsonMap['duration'] != null
          ? int.parse(jsonMap['duration'].toString())
          : 0;
      difficultyLevel = jsonMap['difficulty_level'] != null
          ? int.parse(jsonMap['difficulty_level'].toString())
          : 0;
      price = jsonMap['price'] != null ? double.parse(jsonMap['price']) : 0.0;
      detailsList =
          jsonMap['details'] != null && (jsonMap['details'] as List).length > 0
              ? List.from(jsonMap['details'])
                  .map((element) => UserWorkoutPlanDetails.fromJSON(element))
                  .toList()
              : [];
    } catch (e) {
      print("User Workout Plan Model Error: $e");
    }
  }
}
