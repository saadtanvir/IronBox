import 'package:ironbox/src/models/dietPlanMealDish.dart';

class DietPlanMeal {
  String id;
  String planId;
  String title;
  String time;
  int status; // for user tracking
  int weekNumber;
  int dayNumber;
  double totalFat;
  double totalProtein;
  double totalCalories;
  double totalCarbs;
  List<DietPlanMealDish> dishes;

  DietPlanMeal();

  DietPlanMeal.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      planId = jsonMap['plan_id'] != null ? jsonMap['plan_id'] : "";
      title = jsonMap['title'] != null ? jsonMap['title'] : "";
      time = jsonMap['time'] != null ? jsonMap['time'] : "";
      status = jsonMap['status'] != null
          ? int.parse(jsonMap['status'].toString())
          : 0;
      weekNumber = jsonMap['week_number'] != null
          ? int.parse(jsonMap['week_number'])
          : 0;
      dayNumber =
          jsonMap['day_number'] != null ? int.parse(jsonMap['day_number']) : 0;
      totalCalories = jsonMap['total_calories'] != null
          ? double.parse(jsonMap['total_calories'])
          : 1.0;
      totalCarbs = jsonMap['total_carbohydrates'] != null
          ? double.parse(jsonMap['total_carbohydrates'])
          : 1.0;
      totalFat = jsonMap['total_fat'] != null
          ? double.parse(jsonMap['total_fat'])
          : 1.0;
      totalProtein = jsonMap['total_protein'] != null
          ? double.parse(jsonMap['total_protein'])
          : 1.0;
      dishes =
          jsonMap['dishes'] != null && (jsonMap['dishes'] as List).length > 0
              ? List.from(jsonMap['dishes'])
                  .map((element) => DietPlanMealDish.fromJSON(element))
                  .toList()
              : [];
    } catch (e) {
      print("Diet Plan Meal Model Error: $e");
    }
  }
}
