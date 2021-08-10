import 'dart:io';

import 'package:ironbox/src/models/rating.dart';

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
  String description;
  String role;
  String userToken;
  String avatar;
  String workout;
  String isTrainer;
  String isTrainee;
  String price;
  String videoUrl;
  int age;
  int isPremiumUser = 0;
  int accountStatus = 0;
  int specializationCategory; // 1 = Workout, 2 = Diet
  int questionareStatus; // 0 = incomplete, 1 = completed
  double height;
  double weight;
  double calBurn;
  File avatarImageFile;
  Rating userRating;
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
      specializationCategory = jsonMap['specialisation_category'] != null
          ? int.parse(jsonMap['specialisation_category'])
          : 0;
      questionareStatus = jsonMap['questionare_status'] != null
          ? int.parse(jsonMap['questionare_status'])
          : 0;
      isTrainee = jsonMap['is_trainee'] != null
          ? jsonMap['is_trainee'].toString()
          : "0";
      isTrainer = jsonMap['is_trainer'] != null
          ? jsonMap['is_trainer'].toString()
          : "0";
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
      calBurn = jsonMap['calories_burn'] != null
          ? double.parse(jsonMap['calories_burn'])
          : 0.0;
      specializesIn =
          jsonMap['specializesIn'] != null ? jsonMap['specializesIn'] : '';
      description =
          jsonMap['description'] != null ? jsonMap['description'] : '';
      videoUrl = jsonMap['videoUrl'] != null ? jsonMap['videoUrl'] : '';
      role = jsonMap['usertype'] != null ? jsonMap['usertype'] : '';
      gender = jsonMap['gender'] != null ? jsonMap['gender'] : '';
      experience = jsonMap['experience'] != null ? jsonMap['experience'] : '';
      price = jsonMap['price'] != null ? jsonMap['price'] : '';
      userToken = jsonMap['token'] != null ? jsonMap['token'].toString() : null;
      userRating =
          jsonMap['ratings'] != null && (jsonMap['ratings'] as List).length > 0
              ? Rating.fromJSON(jsonMap['ratings'][0])
              : new Rating();
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
    map["is_trainer"] = isTrainer;
    map["is_trainee"] = isTrainee;
    // map["accountStatus"] = accountStatus.toString();
    map["gender"] = gender;
    map["height"] = height.toString();
    map["weight"] = weight.toString();
    map["injury"] = injury;
    // map["token"] = userToken;
    map["medicalBackground"] = medicalBG;
    map["familyMedicalBackground"] = familyMedicalBG;
    map["specializesIn"] = specializesIn;
    map["experience"] = experience;
    map["description"] = description;
    map["videoUrl"] = videoUrl;
    return map;
  }
}
