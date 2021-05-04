import 'dart:convert';
import 'dart:io';
import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/models/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

Future<Stream<Plan>> getPlansByCategory(String category) async {
  Uri uri = Helper.getUri('plans');
  // Map<String, String> body = {"app_catagory": category};
  Map<String, dynamic> _queryParams = {"category": category};
  uri = uri.replace(queryParameters: _queryParams);
  print("URI For Getting Plans By Category: ${uri.toString()}");
  try {
    final client = new http.Client();
    // client.po
    final streamedRest = await client.send(http.Request('post', uri));

    print(streamedRest.stream.map((data) {
      print(data);
    }));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          print(data);
          return Helper.getData(data);
        })
        .expand((data) => (data as List))
        .map((data) {
          print("printing plans data");
          print(data);
          return Plan.fromJSON(data);
        });
  } on SocketException {
    print("Plan Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Plan Repo Error: $e");
    return new Stream.value(new Plan.fromJSON({}));
  }
}

Future<Stream<Plan>> getUserPlansByCategory(
  String category,
  String uid,
) async {
  Uri uri = Helper.getUri('userplans');
  // Map<String, String> body = {"app_catagory": category};
  Map<String, dynamic> _queryParams = {
    "app_catagory": category,
    "user_id": uid
  };
  uri = uri.replace(queryParameters: _queryParams);
  print("URI For Getting User Plans By Category: ${uri.toString()}");
  try {
    final client = new http.Client();
    // client.po
    final streamedRest = await client.send(http.Request('post', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      print("printing plans data");
      print(data);
      return Plan.fromJSON(data);
    });
  } on SocketException {
    print("Plan Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Plan Repo Error: $e");
    return new Stream.value(new Plan.fromJSON({}));
  }
}
