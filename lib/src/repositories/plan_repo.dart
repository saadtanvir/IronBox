import 'dart:convert';
import 'dart:io';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
// import 'package:dio/dio.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:ironbox/src/models/reviews.dart';
import 'package:ironbox/src/models/workoutPlan.dart';
import 'package:ironbox/src/models/workoutPlanDetails.dart';
import 'package:ironbox/src/models/workoutPlanExercise.dart';
import 'package:ironbox/src/models/workoutPlanGame.dart';

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

Future<Stream<WorkoutPlan>> getTrainerWorkoutPlans(String uid) async {
  Uri uri = Helper.getUri('trainer_workout_plans/$uid');
  // Map<String, dynamic> _queryParams = {"created_by": uid};
  // uri = uri.replace(queryParameters: _queryParams);
  print("URI For Getting Trainer Plans: $uri");

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      print("printing trainer plans data");
      print(data);
      return WorkoutPlan.fromJSON(data);
    });
  } on SocketException {
    print("Plan Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Plan Repo Error: $e");
    return new Stream.value(new WorkoutPlan.fromJSON({}));
  }
}

Future<WorkoutPlan> createWorkoutPlan(WorkoutPlan plan,
    {String imageBytes, File image}) async {
  print("creating plan");
  String url = "${GlobalConfiguration().get("api_base_url")}workout_plans";
  String imageType = image.path.split('.').last;

  try {
    Map<String, String> bodyMap = {
      "title": plan.title,
      "description": plan.description,
      "caution": plan.caution,
      "price": plan.price.toString(),
      "trainer_id": plan.trainerId,
      "cover_video": plan.videoUrl,
      "difficulty_level": plan.difficultyLevel.toString(),
      "duration": plan.durationInWeeks.toString(),
      "category": plan.categoryId,
      "muscle_type": plan.muscleType,
      "status": plan.status.toString()
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(bodyMap);
    request.files.add(await http.MultipartFile.fromPath("cover_img", image.path,
        contentType: MediaType("image", imageType)));

    var response = await request.send();

    // var response = await dio.post(
    //   url,
    //   data: formData,
    //   options: Options(headers: headers),
    // );

    print("URL For Creating Workout Plan: $url");
    print("plan creating status: ${response.statusCode}");

    var res = await http.Response.fromStream(response);
    print(res.body);
    Map jsonBody = json.decode(res.body);
    print(jsonBody['data']);
    if (res.statusCode == 200 && jsonBody['data'] != null) {
      return WorkoutPlan.fromJSON(jsonBody['data'][0]);
    } else {
      print("Exception thrown");
      return WorkoutPlan.fromJSON({});
    }
  } catch (e) {
    print("Error creating plan: $e");
    return WorkoutPlan.fromJSON({});
  }
}

Future<WorkoutPlan> updateWorkoutPlan(WorkoutPlan plan, File image) async {
  print("updating plan");
  String url =
      "${GlobalConfiguration().get("api_base_url")}workout_plans/${plan.id}";
  String imageType = image.path.split('.').last;

  print(plan.id.toString());

  try {
    Map<String, String> bodyMap = {
      "title": plan.title,
      "description": plan.description,
      "caution": plan.caution,
      "price": plan.price.toString(),
      "trainer_id": plan.trainerId,
      "cover_video": plan.videoUrl,
      "difficulty_level": plan.difficultyLevel.toString(),
      "duration": plan.durationInWeeks.toString(),
      "category": plan.categoryId,
      "muscle_type": plan.muscleType,
      "status": plan.status.toString(),
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    // var m = request.method;
    request.fields.addAll(bodyMap);
    request.files.add(await http.MultipartFile.fromPath("cover_img", image.path,
        contentType: MediaType("image", imageType)));

    print(bodyMap);

    var response = await request.send();

    // var response = await dio.post(
    //   url,
    //   data: formData,
    //   options: Options(headers: headers),
    // );

    print("URL For Updating Workout Plan: $url");
    print("plan updating status: ${response.statusCode}");

    var res = await http.Response.fromStream(response);
    print(res.body);
    Map jsonBody = json.decode(res.body);
    print(jsonBody['data']);
    if (res.statusCode == 200 && jsonBody['data'] != null) {
      return WorkoutPlan.fromJSON(jsonBody['data'][0]);
    } else {
      print("Exception thrown");
      return WorkoutPlan.fromJSON({});
    }
  } catch (e) {
    print("Error updating plan: $e");
    return WorkoutPlan.fromJSON({});
  }
}

Future<WorkoutPlan> updateWorkoutPlanWithoutImage(
    WorkoutPlan plan, File image) async {
  print("updating plan");
  String url =
      "${GlobalConfiguration().get("api_base_url")}workout_plans/${plan.id}";
  // String imageType = image.path.split('.').last;

  print(plan.status.toString());

  try {
    Map<String, String> bodyMap = {
      "title": plan.title,
      "description": plan.description,
      "caution": plan.caution,
      "price": plan.price.toString(),
      "trainer_id": plan.trainerId,
      "cover_video": plan.videoUrl,
      "difficulty_level": plan.difficultyLevel.toString(),
      "duration": plan.durationInWeeks.toString(),
      "category": plan.categoryId,
      "muscle_type": plan.muscleType,
      "status": plan.status.toString(),
    };

    // var request = http.MultipartRequest('PUT', Uri.parse(url));
    // request.fields.addAll(bodyMap);
    // request.files.add(await http.MultipartFile.fromPath("cover_img", image.path,
    //     contentType: MediaType("image", imageType)));

    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.put(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8'
      },
      body: json.encode(bodyMap),
    );

    print(bodyMap);

    // var response = await request.send();

    // var response = await dio.post(
    //   url,
    //   data: formData,
    //   options: Options(headers: headers),
    // );

    print("URL For Updating Workout Plan: $url");
    print("plan updating status: ${response.statusCode}");

    // var res = await http.Response.fromStream(response);
    print(response.body);
    Map jsonBody = json.decode(response.body);
    print(jsonBody['data']);
    if (response.statusCode == 200 && jsonBody['data'] != null) {
      return WorkoutPlan.fromJSON(jsonBody['data'][0]);
    } else {
      print("Exception thrown");
      return WorkoutPlan.fromJSON({});
    }
  } catch (e) {
    print("Error updating plan: $e");
    return WorkoutPlan.fromJSON({});
  }
}

Future<WorkoutPlanDetails> createWorkoutPlanDetails(
    WorkoutPlanDetails details) async {
  String url =
      "${GlobalConfiguration().get("api_base_url")}workout_plans_details";
  try {
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      body: json.encode(details.toMap()),
    );

    print(json.encode(details.toMap()));

    print(response.statusCode);
    Map jsonBody = json.decode(response.body);

    if (response.statusCode == 200 && jsonBody['data'] != null) {
      return WorkoutPlanDetails.fromJSON(jsonBody['data'][0]);
    } else {
      print("throws exception");
      throw new Exception(response.body);
    }
  } catch (e) {
    print("error caught");
    print(e);
    return WorkoutPlanDetails.fromJSON({});
  }
}

Future<WorkoutPlanDetails> updateWorkoutPlanDetails(
    WorkoutPlanDetails details) async {
  String url =
      "${GlobalConfiguration().get("api_base_url")}workout_plans_details/${details.id}";
  try {
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.put(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      body: json.encode(details.toMap()),
    );

    print(json.encode(details.toMap()));

    print(response.statusCode);
    Map jsonBody = json.decode(response.body);

    if (response.statusCode == 200 && jsonBody['data'] != null) {
      return WorkoutPlanDetails.fromJSON(jsonBody['data'][0]);
    } else {
      print("throws exception");
      throw new Exception(response.body);
    }
  } catch (e) {
    print("error caught");
    print(e);
    return WorkoutPlanDetails.fromJSON({});
  }
}

Future<WorkoutPlanDetails> getWorkoutPlanDetails(
    {@required String planId,
    @required int weekNum,
    @required int dayNum}) async {
  print("updating plan");
  String url =
      "${GlobalConfiguration().get("api_base_url")}day_details/plan_id=$planId/week_number=$weekNum/day_number=$dayNum";

  try {
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8'
      },
    );

    print("URL For Getting Workout Plan Details: $url");
    print("status: ${response.statusCode}");

    // var res = await http.Response.fromStream(response);
    print(response.body);
    Map jsonBody = json.decode(response.body);
    print(jsonBody['data']);
    if (response.statusCode == 200 && jsonBody['data'] != null) {
      return WorkoutPlanDetails.fromJSON(json.decode(response.body)['data'][0]);
    } else {
      // print("Exception thrown");
      return WorkoutPlanDetails.fromJSON({});
    }
  } catch (e) {
    print("Error getting workout plan details: $e");
    return WorkoutPlanDetails.fromJSON({});
  }
}

Future<WorkoutPlanGame> createWorkoutPlanGame(WorkoutPlanGame game) async {
  String url =
      "${GlobalConfiguration().get("api_base_url")}workout_plans_games";

  print("Body: ${json.encode(game.toMap())}");
  try {
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      body: json.encode(game.toMap()),
    );

    print(response.statusCode);
    Map jsonBody = json.decode(response.body);
    print(jsonBody);

    if (response.statusCode == 200 && jsonBody['data'] != null) {
      return WorkoutPlanGame.fromJSON(jsonBody['data'][0]);
    } else {
      print("throws exception");
      throw new Exception(response.body);
    }
  } catch (e) {
    print("error caught");
    print(e);
    return WorkoutPlanGame.fromJSON({});
  }
}

Future<Stream<WorkoutPlanGame>> getWorkoutPlanGames(String detailsId) async {
  Uri uri = Helper.getUri('game_details/$detailsId');
  // Map<String, dynamic> _queryParams = {"created_by": uid};
  // uri = uri.replace(queryParameters: _queryParams);
  print("URI For Getting WP Games: $uri");

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      print("printing worklout plan games data");
      print(data);
      return WorkoutPlanGame.fromJSON(data);
    });
  } on SocketException {
    print("Plan Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Plan Repo Error: $e");
    return new Stream.value(new WorkoutPlanGame.fromJSON({}));
  }
}

Future<WorkoutPlanExercise> createWorkoutPlanExercise(
    WorkoutPlanExercise exercise) async {
  String url =
      "${GlobalConfiguration().get("api_base_url")}workout_plans_exercise";
  try {
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      body: json.encode(exercise.toMap()),
    );

    print(json.encode(exercise.toMap()));

    print(response.statusCode);
    Map jsonBody = json.decode(response.body);

    if (response.statusCode == 200 && jsonBody['data'] != null) {
      return WorkoutPlanExercise.fromJSON(jsonBody['data'][0]);
    } else {
      print("throws exception");
      throw new Exception(response.body);
    }
  } catch (e) {
    print("error caught");
    print(e);
    return WorkoutPlanExercise.fromJSON({});
  }
}

Future<Stream<WorkoutPlanExercise>> getWorkoutPlanGameExercises(
    String gameId) async {
  Uri uri = Helper.getUri('exercise_details/$gameId');
  // Map<String, dynamic> _queryParams = {"created_by": uid};
  // uri = uri.replace(queryParameters: _queryParams);
  print("URI For Getting WP Games Exercises: $uri");

  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      print("printing workout plan game exercises data");
      print(data);
      return WorkoutPlanExercise.fromJSON(data);
    });
  } on SocketException {
    print("Plan Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Plan Repo Error: $e");
    return new Stream.value(new WorkoutPlanExercise.fromJSON({}));
  }
}

Future<Stream<Review>> getWOPReviews(String planId) async {
  Uri uri = Helper.getUri('plan_reviews/$planId');
  print("URI For Getting Plan Reviews: ${uri.toString()}");
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
          print("printing reviews data");
          print(data);
          return Review.fromJSON(data);
        });
  } on SocketException {
    print("User Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Plan Repo Error: $e");
    return new Stream.value(new Review.fromJSON({}));
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
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.put(
      uri,
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
