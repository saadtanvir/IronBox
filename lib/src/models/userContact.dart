class UserContact {
  String contactId;
  String contactImgUrl;
  String contactUsername;

  UserContact();

  UserContact.fromMap(Map<String, dynamic> map) {
    try {
      contactId = map["id"];
      contactImgUrl = map["imgUrl"];
      contactUsername = map["username"];
    } catch (e) {
      print("UserContact Model Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = this.contactId;
    map["imgUrl"] = this.contactImgUrl;
    map["username"] = this.contactUsername;
    return map;
  }
}
