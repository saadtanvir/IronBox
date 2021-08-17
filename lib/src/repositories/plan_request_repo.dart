import 'dart:convert';
import 'dart:io';
import 'package:ironbox/src/models/planRequest.dart';
import '../helpers/helper.dart';
import '../models/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:global_configuration/global_configuration.dart';
import '../models/reviews.dart';
import '../models/userWorkoutPlan.dart';
import '../models/workoutPlan.dart';
import '../models/workoutPlanDetails.dart';
import '../models/workoutPlanExercise.dart';
import '../models/workoutPlanGame.dart';

Future<Stream<PlanRequest>> getTrainerPlanRequests(String trainerId) async {
  Uri uri = Helper.getUri('get_plan_request/$trainerId');
  print("URI For Getting Trainer Plan Requests: ${uri.toString()}");
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          // print(data);
          return Helper.getData(data);
        })
        .expand((data) => (data as List))
        .map((data) {
          print("printing request data");
          // print(data);
          return PlanRequest.fromJSON(data);
        });
  } on SocketException {
    print("Plan Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Plan Repo Error: $e");
    return new Stream.value(new PlanRequest.fromJSON({}));
  }
}

Future<bool> changeRequestStatus(String reqId, String status) async {
  String url =
      "${GlobalConfiguration().get("api_base_url")}update_request_status/$reqId";
  Map<String, String> body = {"status": status};
  try {
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.patch(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8'
      },
      body: json.encode(body),
    );
    print("URL For Changing Plan Request Status: $url");
    print(response.statusCode);
    // print(response.body);

    // Map responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      print("throws exception");
      return false;
    }
  } catch (e) {
    print("Plan Request Repo Error: $e");
    return false;
  }
}
