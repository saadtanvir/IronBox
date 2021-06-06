class Logs {
  String id;
  String title;
  String userId;
  String createdBy;
  String description;
  String dueDate;
  String duration;
  int isCompleted;

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
      title = jsonMap['title'] != null ? jsonMap['title'].toString() : '';
      description = jsonMap['description'] != null
          ? jsonMap['description'].toString()
          : '';
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
