import 'package:ironbox/src/models/dietPlanMeal.dart';
import 'package:ironbox/src/models/user.dart';

class DietPlan {
  String id;
  String title;
  String description;
  String caution;
  String trainerId;
  String traineeId;
  String requestId;
  String imageUrl;
  String goal;
  String version;
  int status;
  int durationInWeeks;
  int difficultyLevel; // 1,2,3 easy, inter, hard
  double protein;
  double fat;
  double calories;
  double carbohydrates;
  // association concept
  User trainer;
  User trainee;
  List<DietPlanMeal> meals;

  // Trainee variables
  double progress;
  int caloriesGain;

  DietPlan();

  DietPlan.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      title = jsonMap['title'] != null ? jsonMap['title'] : "";
      description =
          jsonMap['description'] != null ? jsonMap['description'] : "";
      caution = jsonMap['caution'] != null ? jsonMap['caution'] : "";
      trainerId = jsonMap['trainer_id'] != null ? jsonMap['trainer_id'] : "";
      traineeId = jsonMap['trainee_id'] != null ? jsonMap['trainee_id'] : "";
      requestId = jsonMap['request_id'] != null ? jsonMap['request_id'] : "";
      imageUrl = jsonMap['cover_image'] != null ? jsonMap['cover_image'] : "";
      goal = jsonMap['goal'] != null ? jsonMap['goal'] : "";
      version = jsonMap['version'] != null ? jsonMap['version'] : "";
      status = jsonMap['status'] != null
          ? int.parse(jsonMap['status'].toString())
          : 0;
      durationInWeeks =
          jsonMap['duration'] != null ? int.parse(jsonMap['duration']) : 1;
      difficultyLevel = jsonMap['difficulty_level'] != null
          ? int.parse(jsonMap['difficulty_level'])
          : 0;
      caloriesGain = jsonMap['calories_gain'] != null
          ? int.parse(jsonMap['calories_gain'])
          : 0;
      protein =
          jsonMap['protein'] != null ? double.parse(jsonMap['protein']) : 1.0;

      fat = jsonMap['fat'] != null ? double.parse(jsonMap['fat']) : 1.0;
      carbohydrates = jsonMap['carbohydrates'] != null
          ? double.parse(jsonMap['carbohydrates'])
          : 1.0;
      calories =
          jsonMap['calories'] != null ? double.parse(jsonMap['calories']) : 1.0;
      progress =
          jsonMap['progress'] != null ? double.parse(jsonMap['progress']) : 1.0;
      trainer = jsonMap['trainers'] != null &&
              (jsonMap['trainers'] as List).length > 0
          ? User.fromJSON(jsonMap['trainers'][0])
          : new User();
      trainee = jsonMap['trainees'] != null &&
              (jsonMap['trainees'] as List).length > 0
          ? User.fromJSON(jsonMap['trainees'][0])
          : new User();
      meals = jsonMap['meals'] != null && (jsonMap['meals'] as List).length > 0
          ? List.from(jsonMap['meals'])
              .map((element) => DietPlanMeal.fromJSON(element))
              .toList()
          : [];
    } catch (e) {
      print("Diet Plan Model Error: $e");
    }
  }
}
