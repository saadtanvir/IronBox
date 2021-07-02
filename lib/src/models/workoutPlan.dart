import 'package:ironbox/src/models/rating.dart';
import 'package:ironbox/src/models/workoutPlanDetails.dart';

class WorkoutPlan {
  String id;
  String title;
  String description;
  String caution;
  String trainerId;
  String coverImg;
  String videoUrl;
  String muscleType;
  String categoryId;
  int status;
  int durationInWeeks; // 4 or 6
  int difficultyLevel; // 1 or 2 or 3
  double price;
  List<WorkoutPlanDetails> details;
  Rating rating;

  WorkoutPlan();

  WorkoutPlan.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      title = jsonMap['title'] != null ? jsonMap['title'] : "";
      description =
          jsonMap['description'] != null ? jsonMap['description'] : "";
      caution = jsonMap['caution'] != null ? jsonMap['caution'] : "";
      trainerId = jsonMap['trainer_id'] != null ? jsonMap['trainer_id'] : "";
      coverImg = jsonMap['cover_img'] != null ? jsonMap['cover_img'] : "";
      videoUrl = jsonMap['cover_video'] != null ? jsonMap['cover_video'] : "";
      muscleType = jsonMap['muscle_type'] != null ? jsonMap['muscle_type'] : "";
      categoryId = jsonMap['category'] != null ? jsonMap['category'] : "";
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
      details =
          jsonMap['details'] != null && (jsonMap['details'] as List).length > 0
              ? List.from(jsonMap['details'])
                  .map((element) => WorkoutPlanDetails.fromJSON(element))
                  .toList()
              : [];
      rating =
          jsonMap['ratings'] != null && (jsonMap['ratings'] as List).length > 0
              ? Rating.fromJSON(jsonMap['ratings'][0])
              : new Rating();
    } catch (e) {
      print("Workout Plan Model Error: $e");
    }
  }

  // Map toMap() {
  //   var map = new Map<String, String>();
  //   return map;
  // }
}
