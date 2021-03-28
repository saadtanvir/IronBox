import 'dart:convert';
import 'dart:io';

import 'package:fitness_app/src/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());

// Future<User> register(User user) async {
//   final client = new http.Client();
//   final response = await client.post(
//     url,
//     headers: {
//       HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8',
//       'Charset': 'utf-8'
//     },
//     body: json.encode(user.toMap()),
//   );
//   if (response.statusCode == 200) {
//     setCurrentUser(response.body);
//     currentUser.value = User.fromJSON(json.decode(response.body)['data']);
//   } else {
//     throw new Exception(response.body);
//   }
//   return currentUser.value;
// }

void setCurrentUser() {}

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey("current_user")) {
    currentUser.value =
        User.fromJSON(json.decode(await prefs.get("current_user")));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  currentUser.notifyListeners();
  return currentUser.value;
}
