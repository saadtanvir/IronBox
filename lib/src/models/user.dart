class User {
  String id;
  String name;
  String email;
  String password;
  // String phone;
  String gender;
  String injury;
  String medicalBG;
  String familyMedicalBG;
  int age;
  int purpose;
  double height;
  double weight;
  double bmi;
  bool isTrainer;
  // to check if user is logged in or not
  bool auth;

  User();

  User.fromJSON(Map<String, dynamic> json) {
    try {} catch (e) {
      print("User model error $e");
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
  }
}
