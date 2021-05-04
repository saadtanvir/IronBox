class Plan {
  String id;
  String category;
  String name;
  String duration;
  String imgUrl;
  String videoUrl;
  String description;
  String detail;
  String createdBy;
  double price;

  Plan();

  Plan.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      createdBy =
          jsonMap['createdBy'] != null ? jsonMap['createdBy'].toString() : '';
      category = jsonMap['app_catagory'] != null
          ? jsonMap['app_catagory'].toString()
          : '';
      name =
          jsonMap['plan_name'] != null ? jsonMap['plan_name'].toString() : '';
      duration =
          jsonMap['duration'] != null ? jsonMap['duration'].toString() : '';
      imgUrl =
          jsonMap['bgImgUrl'] != null ? jsonMap['bgImgUrl'].toString() : '';
      videoUrl =
          jsonMap['video_url'] != null ? jsonMap['vedio_url'].toString() : '';
      description = jsonMap['description'] != null
          ? jsonMap['description'].toString()
          : '';
      detail = jsonMap['details'] != null ? jsonMap['details'].toString() : '';
      price = jsonMap['price'] != null ? double.parse(jsonMap['price']) : 0.0;
    } catch (e) {
      print("Plan Model Error: $e");
    }
  }

  Map toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['details'] = detail;
    map['catagory'] = category;
    map['description'] = description;
    map['createdby'] = createdBy;
    map['bgImgUrl'] = imgUrl;
    map['vediourl'] = videoUrl;
    map['price'] = price;
    map['duration'] = duration;
    map['name'] = name;
    return map;
  }
}
