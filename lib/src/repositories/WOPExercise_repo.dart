import 'dart:convert';
import 'dart:io';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ironbox/src/models/userWorkoutPlanExercise.dart';

Future<Stream<UserWorkoutPlanExercise>> getGameExercises(String gameId) async {
  Uri uri = Helper.getUri('fetch_user_plans_exercises/$gameId');
  print("URI For Getting Game Exercises: ${uri.toString()}");
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          print(data);
          return Helper.getData(data);
        })
        .expand((data) => (data as List))
        .map((data) {
          print("printing exercise data");
          print(data);
          return UserWorkoutPlanExercise.fromJSON(data);
        });
  } on SocketException {
    print("WOP Exercise Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Plan Repo Error: $e");
    return new Stream.value(new UserWorkoutPlanExercise.fromJSON({}));
  }
}

Future<bool> addExerciseToLog(
    {@required UserWorkoutPlanExercise exercise,
    @required String date,
    @required String categoryId,
    @required String createdBy,
    @required String userId}) async {
  String url = "${GlobalConfiguration().get("api_base_url")}store_workout_logs";
  Map<String, String> body = {
    "category_id": categoryId,
    "created_date": date,
    "created_by": createdBy,
    "user_id": userId,
    "exercise_id": exercise.id,
  };
  try {
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8'
      },
      body: json.encode(body),
    );
    print("URL For Adding Exercise to Logs: $url");
    print(json.encode(body));
    print(response.statusCode);
    print(response.body);

    // Map responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      print("throws exception");
      return false;
//    throw new Exception(response.body);
    }
  } catch (e) {
    print("error caught");
    print(e.toString());
    return false;
  }
}

Future<bool> changeExerciseStatus(String exerciseId, String status) async {
  String url =
      "${GlobalConfiguration().get("api_base_url")}update_excercise_status/$exerciseId";
  print("URL FOR UPDATING Exercise STATUS: $url");
  Map<String, String> body = {"status": status};
  try {
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.patch(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      body: json.encode(body),
    );

    print(response.statusCode);
    // Map responseBody = json.decode(response.body);
    // print(responseBody.containsKey("errors"));

    if (response.statusCode == 200) {
      print("exercise status updated successfully");
      return true;
    } else {
      print("throws exception");
      throw new Exception(response.body);
    }
    // return currentUser.value;
  } catch (e) {
    print("error caught");
    print("Logs Repo Error: $e");
    return false;
  }
}
