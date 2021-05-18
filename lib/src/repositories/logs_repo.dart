import 'package:fitness_app/src/models/logs.dart';
import 'dart:convert';
import 'dart:io';
import 'package:fitness_app/src/helpers/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

Future<Stream<Logs>> getUserLogs(String id, String date) async {
  Uri uri = Helper.getUri('logs');
  // Map<String, String> body = {"app_catagory": category};
  Map<String, dynamic> _queryParams = {"user_id": id, "createdat": date};
  uri = uri.replace(queryParameters: _queryParams);
  print("URI For Getting User Logs: ${uri.toString()}");
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
          print("printing logs data");
          print(data);
          return Logs.fromJSON(data);
        });
  } on SocketException {
    print("Logs Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Logs Repo Error: $e");
    return new Stream.value(new Logs.fromJSON({}));
  }
}

Future<Logs> addLog(Logs log) async {
  // print(log.title);
  String url = "${GlobalConfiguration().get("api_base_url")}logs";
  // print(json.encode(log.toMap()));
  print("URL FOR ADDING LOG: $url");
  try {
    final client = new http.Client();
    final response = await client.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      body: json.encode(log.toMap()),
    );

    print(response.statusCode);
    // Map responseBody = json.decode(response.body);
    // print(responseBody.containsKey("errors"));

    if (response.statusCode == 200 &&
        json.decode(response.body)['data'] != null) {
      print("log added successfully");
      print(json.decode(response.body)['data']);
      return Logs.fromJSON(json.decode(response.body)['data']);
    } else {
      print("throws exception");
      throw new Exception(response.body);
    }
    // return currentUser.value;
  } catch (e) {
    print("error caught");
    print("Logs Repo Error: $e");
    return Logs.fromJSON({});
  }
}

Future<bool> updateLogStatus(String logId, String status) async {
  String url = "${GlobalConfiguration().get("api_base_url")}logs/$logId";
  print("URL FOR UPDATING LOG STATUS: $url");
  Map<String, String> body = {"status": status};
  try {
    final client = new http.Client();
    final response = await client.put(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      body: json.encode(body),
    );

    print(response.statusCode);
    // Map responseBody = json.decode(response.body);
    // print(responseBody.containsKey("errors"));

    if (response.statusCode == 200) {
      print("log status updated successfully");
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

Future<bool> deleteLog(String logId) async {
  String url = "${GlobalConfiguration().get("api_base_url")}logs/$logId";
  print("URL FOR UPDATING LOG STATUS: $url");
  // Map<String, String> body = {"status": status};
  try {
    final client = new http.Client();
    final response = await client.delete(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      // body: json.encode(body),
    );

    print(response.statusCode);
    // Map responseBody = json.decode(response.body);
    // print(responseBody.containsKey("errors"));

    if (response.statusCode == 200) {
      print("log deleted successfully");
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
