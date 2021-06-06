class Category {
  String id;
  String name;
  String backgroundImgUrl;

  Category();
  // Category(this.id, this.backgroundImgUrl, this.name);

  Category.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap["id"].toString();
      name = jsonMap["name"].toString();
      backgroundImgUrl = jsonMap["bgImgUrl"].toString();
    } catch (e) {
      print("Category Model Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["bgImgUrl"] = backgroundImgUrl;
    return map;
  }
}
