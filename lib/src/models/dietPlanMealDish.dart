class DietPlanMealDish {
  String id;
  String mealId;
  String name;
  String quantity;
  String weightInGrams;
  String imageUrl;
  String description;
  String caution;
  int status; // for user tracking
  double protein;
  double fat;
  double calories;
  double carbohydrates;

  DietPlanMealDish();

  DietPlanMealDish.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      mealId = jsonMap['meal_id'] != null ? jsonMap['meal_id'] : "";
      name = jsonMap['name'] != null ? jsonMap['name'] : "";
      quantity = jsonMap['quantity'] != null ? jsonMap['quantity'] : "";
      weightInGrams = jsonMap['weight'] != null ? jsonMap['weight'] : "";
      imageUrl = jsonMap['image'] != null ? jsonMap['image'] : "";
      description =
          jsonMap['description'] != null ? jsonMap['description'] : "";
      caution = jsonMap['caution'] != null ? jsonMap['caution'] : "";
      status = jsonMap['status'] != null
          ? int.parse(jsonMap['status'].toString())
          : 0;
      protein =
          jsonMap['protein'] != null ? double.parse(jsonMap['protein']) : 0.0;
      fat = jsonMap['fat'] != null ? double.parse(jsonMap['fat']) : 0.0;
      calories =
          jsonMap['calories'] != null ? double.parse(jsonMap['calories']) : 0.0;
      carbohydrates = jsonMap['carbohydrates'] != null
          ? double.parse(jsonMap['carbohydrates'])
          : 0.0;
    } catch (e) {
      print("Diet Plan Meal Dish Model Error: $e");
    }
  }
}
