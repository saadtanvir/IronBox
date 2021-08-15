import 'package:ironbox/src/models/requestQuestionAnswer.dart';
import 'package:ironbox/src/models/user.dart';

class PlanRequest {
  String id;
  String trainerId;
  String traineeId;
  String date;
  // 1 = pending, 2 = accepted, 3 = rejected, 4 = completed
  int reqStatus;
  int category; // 1 = workout, 2 = diet
  int paymentStatus; // 0 and 1
  double price;
  User trainee;
  List<RequestQuestionAnswer> requestQuestionsAnswersList;

  PlanRequest();

  PlanRequest.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      trainerId = jsonMap['trainer_id'] != null ? jsonMap['trainer_id'] : "";
      traineeId = jsonMap['trainee_id'] != null ? jsonMap['trainee_id'] : "";
      date = jsonMap['created_date'] != null ? jsonMap['created_date'] : "";
      reqStatus = jsonMap['status'] != null ? int.parse(jsonMap['status']) : 0;
      category =
          jsonMap['category'] != null ? int.parse(jsonMap['category']) : 0;
      paymentStatus = jsonMap['payment_status'] != null
          ? int.parse(jsonMap['payment_status'])
          : 0;
      price = jsonMap['price'] != null ? double.parse(jsonMap['price']) : 0.0;
      trainee = jsonMap['trainee'] != null
          ? User.fromJSON(jsonMap['trainee'][0])
          : User.fromJSON({});
      requestQuestionsAnswersList =
          jsonMap['answers'] != null && (jsonMap['answers'] as List).length > 0
              ? List.from(jsonMap['answers'])
                  .map((element) => RequestQuestionAnswer.fromJSON(element))
                  .toList()
              : [];
    } catch (e) {
      print("Plan Request Model Error: $e");
    }
  }

  Map toMap() {
    var map = Map<String, dynamic>();
    // List<Map> requestAnswers = [];
    map['trainer_id'] = trainerId;
    map['trainee_id'] = traineeId;
    map['status'] = reqStatus.toString();
    map['price'] = price.toString();
    map['category'] = category.toString();
    map['created_date'] = date;
    map['payment_status'] = paymentStatus.toString();
    // map['answers'] =
    return map;
  }
}
