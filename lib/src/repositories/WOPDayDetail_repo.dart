import 'dart:convert';
import 'dart:io';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ironbox/src/models/userWorkoutPlanDetails.dart';
import 'package:ironbox/src/models/userWorkoutPlanExercise.dart';

Future<UserWorkoutPlanDetails> getSingleDayDetails(
    {@required String planId,
    @required String weekNum,
    @required String dayNum}) async {
  Uri uri = Helper.getUri(
      'fetch_user_plans_details/plan_id=$planId/week_no=$weekNum/day_no=$dayNum');
  print("URI For Getting User Plan Single Day Details: ${uri.toString()}");

  try {
    // Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8'
      },
    );

    print("status: ${response.statusCode}");

    // var res = await http.Response.fromStream(response);
    print(response.body);
    Map jsonBody = json.decode(response.body);
    print(jsonBody['data']);
    if (response.statusCode == 200 && jsonBody['data'] != null) {
      return UserWorkoutPlanDetails.fromJSON(jsonBody['data'][0]);
    } else {
      // print("Exception thrown");
      return UserWorkoutPlanDetails.fromJSON({});
    }
  } catch (e) {
    print("User WOP DAY DETAIL REPO ERROR: $e");
    return UserWorkoutPlanDetails.fromJSON({});
  }
}
