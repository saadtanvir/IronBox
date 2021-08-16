import 'package:ironbox/src/models/trainerQuestion.dart';

class RequestQuestionAnswer {
  String id;
  String statement;
  String trainerQuestionId;
  String planRequestId;
  TrainerQuestion trainerQuestion;

  RequestQuestionAnswer();

  RequestQuestionAnswer.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      statement = jsonMap['answer_statement'] != null
          ? jsonMap['answer_statement']
          : "";
      trainerQuestionId = jsonMap['trainer_question_id'] != null
          ? jsonMap['trainer_question_id']
          : "";
      planRequestId =
          jsonMap['plan_request_id'] != null ? jsonMap['plan_request_id'] : "";
      trainerQuestion = jsonMap['trainer_question'] != null
          ? TrainerQuestion.fromJSON(jsonMap['trainer_question'][0])
          : TrainerQuestion.fromJSON({});
    } catch (e) {
      print("Request Question Answer Model Error: $e");
    }
  }

  Map toMap() {
    var map = Map<String, dynamic>();
    map['answer_statement'] = statement;
    map['trainer_question_id'] = trainerQuestionId;
    return map;
  }
}
