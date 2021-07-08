class Logs {
  String id;
  String userId;
  String exerciseId;
  String mealId;
  String createdBy;
  String title;
  String description;
  String videoUrl;
  String dueDate;
  String duration; // in minutes
  int isCompleted;
  int reps;
  int calBurn;
  int calGain;
  int categoryId; // 1 = workout, 2 = diet

  Logs();

  Logs.test(
      {this.dueDate,
      this.description,
      this.duration,
      this.id,
      this.isCompleted,
      this.title});

  Logs.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      exerciseId = jsonMap['exercise_id'] != null
          ? jsonMap['exercise_id'].toString()
          : "";
      mealId = jsonMap['meal_id'] != null ? jsonMap['meal_id'].toString() : "";
      categoryId = jsonMap['category_id'] != null
          ? int.parse(jsonMap['category_id'])
          : 1;
      title = jsonMap['title'] != null ? jsonMap['title'].toString() : '';
      description = jsonMap['description'] != null
          ? jsonMap['description'].toString()
          : '';
      videoUrl = jsonMap['video_url'] != null ? jsonMap['video_url'] : "";
      userId = jsonMap['user_id'] != null ? jsonMap['user_id'].toString() : '';
      createdBy =
          jsonMap['createdBy'] != null ? jsonMap['createdBy'].toString() : '';
      dueDate =
          jsonMap['createdAt'] != null ? jsonMap['createdAt'].toString() : '';
      duration =
          jsonMap['duration'] != null ? jsonMap['duration'].toString() : '';
      isCompleted = jsonMap['status'] != null
          ? int.parse(jsonMap['status'].toString())
          : 0;
      reps = jsonMap['reps'] != null ? int.parse(jsonMap['reps']) : 0;
      calBurn =
          jsonMap['cal_burn'] != null ? int.parse(jsonMap['cal_burn']) : 0;
      calGain =
          jsonMap['cal_gain'] != null ? int.parse(jsonMap['cal_gain']) : 0;
    } catch (e) {
      print("Logs Model Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['title'] = title;
    map['description'] = description;
    map['user_id'] = userId;
    map['createdby'] = createdBy;
    map['createdat'] = dueDate;
    map['duration'] = duration;
    map['status'] = isCompleted.toString();
    return map;
  }
}
