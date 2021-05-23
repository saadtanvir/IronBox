import 'dart:convert';
import 'dart:io';
import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/models/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
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

Future<Stream<Plan>> searchPlans(String searchString, String category) async {
  Uri uri = Helper.getUri('searchplan');
  Map<String, dynamic> _queryParams = {
    "name_string": searchString,
    "category": category,
  };
  uri = uri.replace(queryParameters: _queryParams);
  print("URI For Searching Plans By Category: ${uri.toString()}");
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
  Uri uri = Helper.getUri('fetchplan');
  Map<String, dynamic> _queryParams = {"category": category, "user_id": uid};
  uri = uri.replace(queryParameters: _queryParams);
  print("URI For Getting User Plans By Category: ${uri.toString()}");
  try {
    final client = new http.Client();
    // client.po
    final streamedRest = await client.send(http.Request('post', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          print("plans response: $data");
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

Future<Stream<Plan>> getTrainerPlans(String uid) async {
  Uri uri = Helper.getUri('fetchplan');
  Map<String, dynamic> _queryParams = {"created_by": uid};
  uri = uri.replace(queryParameters: _queryParams);
  print("URI For Getting Trainer Plans: $uri");

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('post', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      print("printing trainer plans data");
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

Future<Plan> createPlan(Plan plan, {String imageBytes, File image}) async {
  print("creating plan");
  // Dio dio = new Dio();
  String url = "${GlobalConfiguration().get("api_base_url")}plans";
  String imageType = image.path.split('.').last;

  try {
    // Map<String, String> headers = {
    //   "Accept": "*/*",
    //   "Content-Type": "multipart/form-data"
    // };
    // FormData formData = new FormData.fromMap({
    //   "coverimg": await MultipartFile.fromFile(image.path,
    //       contentType: MediaType("image", imageType)),
    //   "name": plan.name,
    //   "category": plan.category,
    //   "duration": plan.duration,
    //   "description": plan.description,
    //   "details": plan.detail,
    //   "videourl": plan.videoUrl,
    //   "price": plan.price.toString(),
    //   "createdby": plan.createdBy,
    // });

    Map<String, String> bodyMap = {
      "name": plan.name,
      "category": plan.category,
      "duration": plan.duration,
      "description": plan.description,
      "details": plan.detail,
      "videourl": plan.videoUrl,
      "price": plan.price.toString(),
      "createdby": plan.createdBy,
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(bodyMap);
    request.files.add(await http.MultipartFile.fromPath("coverimg", image.path,
        contentType: MediaType("image", imageType)));

    var response = await request.send();

    // var response = await dio.post(
    //   url,
    //   data: formData,
    //   options: Options(headers: headers),
    // );

    print("URL For Creating Plan: $url");
    print("plan creating status: ${response.statusCode}");

    var res = await http.Response.fromStream(response);
    print(res.body);
    Map responseBody = json.decode(res.body);
    print(responseBody['data']);
    if (res.statusCode == 200 && responseBody['data'] != null) {
      return Plan.fromJSON(json.decode(res.body)['data']);
    } else {
      print("Exception thrown");
      return Plan.fromJSON({});
    }
  } catch (e) {
    print("Error creating plan: $e");
    return Plan.fromJSON({});
  }
}

Future<bool> editPlan(Plan plan) async {
  String url = "${GlobalConfiguration().get("api_base_url")}plans/${plan.id}";
  Map<String, String> body = {
    "category": plan.category,
    "name": plan.name,
    "duration": plan.duration,
    "coverimg": plan.imgUrl,
    "description": plan.description,
    "details": plan.detail,
    "videourl": plan.videoUrl,
    "price": plan.price.toString(),
    "createdby": plan.createdBy,
  };
  try {
    final client = new http.Client();
    final response = await client.put(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8'
      },
      body: json.encode(body),
    );
    print("URL For Editing Plan: $url");
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
//  return currentUser.value;
  } catch (e) {
    print("error caught");
    print(e.toString());
    return false;
  }
}
