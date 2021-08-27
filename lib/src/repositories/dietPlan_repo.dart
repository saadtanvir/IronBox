import 'dart:convert';
import 'dart:io';
import 'package:ironbox/src/models/dietPlan.dart';
import '../helpers/helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:global_configuration/global_configuration.dart';

Future<DietPlan> createDietPlan(DietPlan plan, File coverImage) async {
  String url = "${GlobalConfiguration().get("api_base_url")}store_diet_plan";
  String imageType = coverImage.path.split('.').last;
  try {
    Map<String, String> bodyMap = {
      "title": plan.title,
      "difficulty_level": plan.difficultyLevel.toString(),
      "description": plan.description,
      "duration": plan.durationInWeeks.toString(),
      "category": "2",
      "protein": plan.protein.toString(),
      "fat": plan.fat.toString(),
      "calories": plan.calories.toString(),
      "carbohydrates": plan.carbohydrates.toString(),
      "goal": plan.goal,
      "caution": plan.caution,
      "request_id": plan.requestId,
      "trainee_id": plan.traineeId,
      "trainer_id": plan.trainerId,
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(bodyMap);
    if (coverImage.path != null) {
      request.files.add(await http.MultipartFile.fromPath(
          "cover_image", coverImage.path,
          contentType: MediaType("image", imageType)));
    }

    var response = await request.send();

    // var response = await dio.post(
    //   url,
    //   data: formData,
    //   options: Options(headers: headers),
    // );

    print("URL For Creating Diet Plan: $url");
    print("${response.statusCode}");

    var res = await http.Response.fromStream(response);
    // print(res.body);
    Map responseBody = json.decode(res.body);
    // print(responseBody['data'][0]);
    if (res.statusCode == 200 && responseBody['data'] != null) {
      return DietPlan.fromJSON(responseBody['data'][0]);
    } else {
      print("Exception thrown");
      return DietPlan.fromJSON({});
    }
  } catch (e) {
    print("Error creating diet plan: $e");
    return DietPlan.fromJSON({});
  }
}

Future<bool> deleteDietPlan(String planId) async {
  String url =
      "${GlobalConfiguration().get("api_base_url")}delete_diet_plan/$planId";
  print("URL FOR DELETING Diet Plan: $url");
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
      print("diet plan deleted successfully");
      return true;
    } else {
      print("throws exception");
      throw new Exception(response.body);
    }
    // return currentUser.value;
  } catch (e) {
    print("error caught");
    print("Diet Plans Repo Error: $e");
    return false;
  }
}
