import 'dart:convert';
import 'dart:io';
import 'package:ironbox/src/helpers/app_constants.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/subscriptions.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());
// FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

Future<User> register(User user) async {
  // print(user.name);
  String url = "${GlobalConfiguration().get("api_base_url")}registeruser";
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
      currentUser.value = User.fromJSON(json.decode(response.body)['data'][0]);
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

Future<User> registerUserWithImage(User user) async {
  print(user.avatarImageFile != null);
  String url = "${GlobalConfiguration().get("api_base_url")}registeruser";

  Map<String, String> body = {
    "email": user.email,
    "name": user.name,
    "password": user.password,
    "phone": user.phone,
    "username": user.userName,
    "usertype": user.role,
    "age": user.age.toString(),
    "gender": user.gender,
    "is_trainee": user.isTrainee,
    "is_trainer": user.isTrainer,
    "price": user.price ?? "",
    "video": user.videoUrl ?? "",
    "isPremiumUser":
        user.isPremiumUser != null ? user.isPremiumUser.toString() : "0",
    "height": user.height.toString(),
    "weight": user.weight.toString(),
    // "token": user.userToken != null ? user.userToken : "",
    "injury": user.injury != null ? user.injury : "",
    "medicalBackground": user.medicalBG != null ? user.medicalBG : "",
    "familyMedicalBackground":
        user.familyMedicalBG != null ? user.familyMedicalBG : "",
    "specializesIn": user.specializesIn != null ? user.specializesIn : "",
    "experience": user.experience != null ? user.experience : "",
    "description": user.description ?? "",
  };

  print(user.isPremiumUser);

  print("URL FOR REGISTRING USER WITH IMAGE: $url");

  try {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(body);

    if (user.avatarImageFile != null) {
      String imageType = user.avatarImageFile.path.split('.').last;
      request.files.add(await http.MultipartFile.fromPath(
          "avatar", user.avatarImageFile.path,
          contentType: MediaType("image", imageType)));
    }

    print("user registration params: $body");

    var response = await request.send();
    print("response: $response");

    var res = await http.Response.fromStream(response);

    print(response.statusCode);
    print(res.body);
    Map jsonBody = json.decode(res.body);
    print("json body: $jsonBody");
    print("has errors: ${jsonBody.containsKey("errors")}");

    if (res.statusCode == 200 && !jsonBody.containsKey("errors")) {
      // setCurrentUser(res.body);
      // print("user saved in sharedprefs");
      currentUser.value = User.fromJSON(jsonBody['data'][0]);
      print("user created successfully");
    } else {
      print("throws exception");
      currentUser.value = User.fromJSON({});
      throw new Exception(res.body);
    }
    return currentUser.value;
  } catch (e) {
    print("error caught");
    print(e);
    return currentUser.value = User.fromJSON({});
  }
}

Future<User> login(User user) async {
  final String url = "${GlobalConfiguration().get("api_base_url")}login";
  print("URL FOR LOGIN: $url");
  try {
    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8'
      },
      body: json.encode(user.toMap()),
    );
    print("login params: ${json.encode(user.toMap())}");
    print(response.statusCode);
    print(response.body);

    Map jsonBody = json.decode(response.body);
    print("user object: ${jsonBody['data'][0]}");

    if (response.statusCode == 200 && jsonBody['data'][0]['token'] != null) {
      setCurrentUser(response.body);
      setUserRole(json.decode(response.body)['data'][0]['usertype']);
      print("response 200");
      currentUser.value = User.fromJSON(json.decode(response.body)['data'][0]);

      return currentUser.value;
    } else {
      print("throws exception");
      return currentUser.value;
    }
  } catch (e) {
    print("error caught");
    print(e.toString());
    return currentUser.value;
  }
}

Future<User> updateUser(User u) async {
  String url =
      "${GlobalConfiguration().get("api_base_url")}registeruser/${u.id}";
  try {
    final client = new http.Client();
    final response = await client.put(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8'
      },
      body: json.encode(u.toMap()),
    );
    print("URL For Updating Current User: $url");
    print(json.encode(u.toMap()));
    print(response.statusCode);
    print(response.body);

    Map responseBody = json.decode(response.body);
    // print(responseBody['data']['token']);

    if (response.statusCode == 200 && responseBody['data'] != null) {
      setCurrentUser(response.body);
      // setUserRole(json.decode(response.body)['data']['usertype']);
      currentUser.value = User.fromJSON(json.decode(response.body)['data']);

      return currentUser.value;
    } else {
      print("throws exception");
      return currentUser.value;
    }
  } catch (e) {
    print("error caught");
    print(e.toString());
    return currentUser.value;
  }
}

Future<Stream<User>> fetchAllTrainers() async {
  Uri uri = Helper.getUri('trainers');
  // Map<String, dynamic> _queryParams = {"category": category};
  // uri = uri.replace(queryParameters: _queryParams);
  print("URI For Getting Trainers: ${uri.toString()}");
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    // print(streamedRest.stream.map((data) {
    //   print(data);
    // }));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          print(data);
          return Helper.getData(data);
        })
        .expand((data) => (data as List))
        .map((data) {
          print("printing trainers data");
          print(data);
          return User.fromJSON(data);
        });
  } on SocketException {
    print("User Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("User Repo Error: $e");
    return new Stream.value(new User.fromJSON({}));
  }
}

Future<Stream<User>> getUserContacts(String userId) async {
  Uri uri = Helper.getUri('contacts/$userId');
  // Map<String, dynamic> _queryParams = {"category": category};
  // uri = uri.replace(queryParameters: _queryParams);
  print("URI For Getting User Contacts: ${uri.toString()}");
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    // print(streamedRest.stream.map((data) {
    //   print(data);
    // }));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          print(data);
          return Helper.getData(data);
        })
        .expand((data) => (data as List))
        .map((data) {
          print("printing trainers data");
          print(data);
          return User.fromJSON(data);
        });
  } on SocketException {
    print("User Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("User Repo Error: $e");
    return new Stream.value(new User.fromJSON({}));
  }
}

Future<bool> subscribeTrainer(Subscription sub) async {
  String url = "${GlobalConfiguration().get("api_base_url")}subscriptions";
  try {
    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8'
      },
      body: json.encode(sub.toMap()),
    );
    print("URL For Subscribing Trainer: $url");
    print(json.encode(sub.toMap()));
    print(response.statusCode);
    print(response.body);

    Map responseBody = json.decode(response.body);
    // print(responseBody['data']['token']);

    if (response.statusCode == 200) {
      print("trainer subscribed");
      return true;
    } else {
      print("throws exception");
      return false;
    }
  } catch (e) {
    print("error caught");
    print(e.toString());
    return false;
  }
}

void setCurrentUser(jsonString) async {
  print(json.encode(json.decode(jsonString)['data'][0]));
  if (json.decode(jsonString)['data'][0] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'current_user', json.encode(json.decode(jsonString)['data'][0]));
  }
}

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey("current_user")) {
    print("User Repo: user found from shared prefs");
    // next both statement will call listeners
    currentUser.value.role = await prefs.getString("user_role");
    print(json.decode(await prefs.get("current_user")));
    currentUser.value =
        User.fromJSON(json.decode(await prefs.get("current_user")));
    // print(await prefs.get("current_user"));
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

Future<void> removeCurrentUser() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
  await prefs.remove("user_role");
  print("User Repo: user removed successfully");
}

void setUserRole(String role) async {
  print("new user role is: $role");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("user_role", role);
  currentUser.value.role = role;
}
