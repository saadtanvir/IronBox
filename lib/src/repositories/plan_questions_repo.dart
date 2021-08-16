import 'package:flutter/material.dart';
import '../helpers/helper.dart';
import '../models/planRequest.dart';
import '../models/questions.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';
import 'package:ironbox/src/models/trainerQuestion.dart';

Future<bool> submitCustomPlanRequest(
    PlanRequest request, List<Map> reqAnswers) async {
  String url = "${GlobalConfiguration().get("api_base_url")}request_plan";
  print("URL FOR Submitting Custom Plan Req: $url");
  var body = {
    "trainer_id": request.trainerId,
    "trainee_id": request.traineeId,
    "status": request.reqStatus.toString(),
    "price": request.price.toString(),
    "category": request.category.toString(),
    "created_date": request.dateRequested,
    "payment_status": request.paymentStatus.toString(),
    "answers": reqAnswers,
  };
  try {
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
      body: json.encode(body),
    );

    print(response.statusCode);
    // Map responseBody = json.decode(response.body);
    // print(responseBody);

    if (response.statusCode == 200) {
      print("request submitted successfully");
      return true;
    } else {
      print("throws exception");
      throw new Exception(response.body);
    }
  } catch (e) {
    print("error caught");
    print("Plans Question Repo Error: $e");
    return false;
  }
}

Future<Stream<Question>> getPlanQuestions(String categoryId) async {
  Uri uri = Helper.getUri('all_questions/category=$categoryId');
  print("URI For Getting All Questions: ${uri.toString()}");
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          // print("plans response: $data");
          return Helper.getData(data);
        })
        .expand((data) => (data as List))
        .map((data) {
          print("printing all questions ");
          // print(data);
          return Question.fromJSON(data);
        });
  } on SocketException {
    print("Plan Questions Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Plan Questions Repo Error: $e");
    return new Stream.value(new Question.fromJSON({}));
  }
}

// to get trainer questions from TrainerQuestions table
Future<Stream<TrainerQuestion>> getTrainerQuestions(String trainerId) async {
  Uri uri = Helper.getUri('trainer_questions/$trainerId');
  print("URI For Getting Trainer Questions: ${uri.toString()}");
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          // print("plans response: $data");
          return Helper.getData(data);
        })
        .expand((data) => (data as List))
        .map((data) {
          print("trainer question data: ");
          // print(data);
          return TrainerQuestion.fromJSON(data);
        });
  } on SocketException {
    print("Plan Questions Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Plan Questions Repo Error: $e");
    return new Stream.value(new TrainerQuestion.fromJSON({}));
  }
}

// to add question in TrainerQuestion table
Future<bool> addQuestionForTrainer(
    {@required String questionId,
    @required String trainerId,
    @required String isOptional}) async {
  String url = "${GlobalConfiguration().get("api_base_url")}trainer_questions";
  print("URL FOR Adding Question For Trainer: $url");
  Map<String, String> body = {
    "trainer_id": trainerId,
    "question_id": questionId,
    "optional": isOptional
  };
  try {
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.post(
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
      print("question added successfully");
      return true;
    } else {
      print("throws exception");
      throw new Exception(response.body);
    }
  } catch (e) {
    print("error caught");
    print("Plans Question Repo Error: $e");
    return false;
  }
}

// to remove question from TrainerQuestions Table
Future<bool> removeQuestionFromTrainer(
    String trainerId, String originalQuestionId) async {
  String url =
      "${GlobalConfiguration().get("api_base_url")}delete_trainer_question/trainer_id=$trainerId/question_id=$originalQuestionId";
  print("URL FOR Deleting Question From Trainer: $url");
  // Map<String, String> body = {
  //   "trainer_id": trainerId,
  //   "question_id": questionId,
  //   "optional": isOptional
  // };
  try {
    Uri uri = Uri.parse(url);
    final client = new http.Client();
    final response = await client.delete(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json;charset=UTF-8'
      },
    );

    print(response.statusCode);
    // Map responseBody = json.decode(response.body);
    // print(responseBody.containsKey("errors"));

    if (response.statusCode == 200) {
      print("question deleted successfully");
      return true;
    } else {
      print("throws exception");
      throw new Exception(response.body);
    }
  } catch (e) {
    print("error caught");
    print("Plans Question Repo Error: $e");
    return false;
  }
}
