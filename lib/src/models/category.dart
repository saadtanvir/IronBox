class Category {
  String id;
  String parent_id;
  String status;
  String name;
  String backgroundImgUrl;

  Category();
  // Category(this.id, this.backgroundImgUrl, this.name);

  Category.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap["id"].toString();
      name = jsonMap["name"].toString();
      backgroundImgUrl = jsonMap["cover_img"].toString();
      parent_id = jsonMap['app_categories_id'] != null
          ? jsonMap['app_categories_id']
          : jsonMap['sub_categories_id'] != null
              ? jsonMap['sub_categories_id']
              : "";
      status = jsonMap['status'] != null ? jsonMap['status'] : "";
    } catch (e) {
      print("Category Model Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["cover_img"] = backgroundImgUrl;
    return map;
  }
}
