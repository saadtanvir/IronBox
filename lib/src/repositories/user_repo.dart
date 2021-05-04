import 'dart:convert';
import 'dart:io';
import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());
// FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

Future<User> register(User user) async {
  // print(user.name);
  String url = "${GlobalConfiguration().get("api_base_url")}register";
  try {
    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      body: json.encode(user.toMap()),
    );

    print(json.encode(user.toMap()));

    print(response.statusCode);
    Map responseBody = json.decode(response.body);
    print(responseBody.containsKey("errors"));

    if (response.statusCode == 200 && !responseBody.containsKey("errors")) {
      setCurrentUser(response.body);
      currentUser.value = User.fromJSON(json.decode(response.body)['data']);
      print("user created successfully");
    } else {
      print("throws exception");
      throw new Exception(response.body);
    }
    return currentUser.value;
  } catch (e) {
    print("error caught");
    print(e);
    return currentUser.value;
  }
}

// Future<User> register2(User user) async {
//   // print(user.name);
//   try {
//     String url = "https://mindwhiz.co/ironbox/public/index.php/api/register";
//     Response response;
//     var dio = Dio();
//     response = await dio.post(url, data: user.toMap());
//     print(response.statusCode);
//     print(response.data);
//     return currentUser.value;
//   } catch (e) {
//     print("error caught");
//     print(e);
//     return currentUser.value;
//   }
// }

Future<User> login(User user) async {
  try {
    final String url = "${GlobalConfiguration().get("api_base_url")}login";
    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8'
      },
      body: json.encode(user.toMap()),
    );
    print(json.encode(user.toMap()));
    print(response.statusCode);
    print(response.body);

    Map responseBody = json.decode(response.body);
    print(responseBody['data']['token']);

    if (response.statusCode == 200 && responseBody['data']['token'] != null) {
      setCurrentUser(response.body);
      setUserRole(json.decode(response.body)['data']['usertype']);
      currentUser.value = User.fromJSON(json.decode(response.body)['data']);

      return currentUser.value;
    } else {
      print("throws exception");
      return currentUser.value;
//    throw new Exception(response.body);
    }
//  return currentUser.value;
  } catch (e) {
    print("error caught");
    print(e.toString());
    return currentUser.value;
  }
}

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['data'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'current_user', json.encode(json.decode(jsonString)['data']));
  }
}

// void setCurrentUser2(User user) async {
//   if (user.userToken != null) {
//     print("setting current user with token");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     print(json.encode(currentUser.value));
//     await prefs.setString('current_user', json.encode(currentUser.value));
//   }
// }

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey("current_user")) {
    print("User Repo: user found from shared prefs");
    currentUser.value =
        User.fromJSON(json.decode(await prefs.get("current_user")));
    currentUser.value.auth = true;
    // currentUser.notifyListeners();
  } else {
    print("User Repo: user not found from shared prefs");
    currentUser.value = User.fromJSON({});
    currentUser.value.auth = false;
    // currentUser.notifyListeners();
  }
  return currentUser.value;
}

// Future<User> getCurrentUser2() async {
//   print("getting current user");
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   if (prefs.containsKey("current_user")) {
//     print(json.decode(await prefs.get("current_user")));
//     currentUser.value = json.decode(await prefs.get("current_user"));
//     print(currentUser.value.id);
//     print(currentUser.value.userToken);
//     // currentUser.value.auth = true;
//   } else {
//     // currentUser.value.auth = false;
//   }
//   currentUser.notifyListeners();
//   return currentUser.value;
// }

Future<void> removeCurrentUser() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
  await prefs.remove("user_role");
  print("User Repo: user removed successfully");
}

void setUserRole(String role) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("user_role", role);
  currentUser.value.role = role;
}

// Future<String> getUserCurrentRole() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("user_role")) {
//     return prefs.getString("user_role");
//   } else {
//     return currentUser.value.role.toString();
//   }
// }
