class UserContact {
  String contactId;
  String createdAt;

  UserContact();
  // UserContact.namedCon(this.contactId, this.createdAt);

  UserContact.fromMap(Map<String, dynamic> map) {
    try {
      contactId = map["id"];
      createdAt = map['created_at'];
    } catch (e) {
      print("UserContact Model Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = this.contactId;
    map['created_at'] = this.createdAt;
    return map;
  }
}
