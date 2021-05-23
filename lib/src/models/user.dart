import 'dart:io';

class User {
  String id;
  String name;
  String userName;
  String email;
  String password;
  String phone;
  String gender;
  String injury;
  String medicalBG;
  String familyMedicalBG;
  String experience;
  String specializesIn;
  String role;
  String userToken;
  String avatar;
  String workout;
  int age;
  int isPremiumUser = 0;
  int accountStatus = 0;
  double height;
  double weight;
  File avatarImageFile;
  // to check if user is logged in or not
  bool auth;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    // getting error on sign up
    // int is not subtype of string
    // some fields might be effected
    // remove these comments after resolving
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'] != null ? jsonMap['name'].toString() : '';
      userName = jsonMap['username'] != null ? jsonMap['username'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'].toString() : '';
      phone = jsonMap['phone'] != null ? jsonMap['phone'] : '';
      password = jsonMap['password'] != null ? jsonMap['password'] : '';
      avatar = jsonMap['imgUrl'] != null ? jsonMap['imgUrl'] : '';
      injury = jsonMap['injury'] != null ? jsonMap['injury'] : '';
      workout = jsonMap['workout'] != null ? jsonMap['workout'] : "0";
      age = jsonMap['age'] != null ? int.parse(jsonMap['age'].toString()) : 0;
      isPremiumUser = jsonMap['isPremiumUser'] != null
          ? int.parse(jsonMap['isPremiumUser'])
          : 0;
      accountStatus = jsonMap['accountStatus'] != null
          ? int.parse(jsonMap['accountStatus'])
          : 0;
      medicalBG = jsonMap['medicalBackground'] != null
          ? jsonMap['medicalBackground']
          : '';
      familyMedicalBG = jsonMap['familyMedicalBackground'] != null
          ? jsonMap['familyMedicalBackground']
          : '';
      height =
          jsonMap['height'] != null ? double.parse(jsonMap['height']) : 0.0;
      weight =
          jsonMap['weight'] != null ? double.parse(jsonMap['weight']) : 0.0;
      specializesIn =
          jsonMap['specializesIn'] != null ? jsonMap['specializesIn'] : '';
      role = jsonMap['usertype'] != null ? jsonMap['usertype'] : '';
      gender = jsonMap['gender'] != null ? jsonMap['gender'] : '';
      experience = jsonMap['experience'] != null ? jsonMap['experience'] : '';
      userToken = jsonMap['token'] != null ? jsonMap['token'].toString() : null;
    } catch (e) {
      print("User Model Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, String>();
    // map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["phone"] = phone;
    map["username"] = userName;
    map["usertype"] = role;
    map["age"] = age.toString();
    // map["avatar"] = avatar;
    map["isPremiumUser"] = isPremiumUser.toString();
    map["accountStatus"] = accountStatus.toString();
    map["gender"] = gender;
    map["height"] = height.toString();
    map["weight"] = weight.toString();
    map["injury"] = injury;
    map["token"] = userToken;
    map["medicalBackground"] = medicalBG;
    map["familyMedicalBackground"] = familyMedicalBG;
    map["specializesIn"] = specializesIn;
    map["experience"] = experience;
    return map;
  }
}
