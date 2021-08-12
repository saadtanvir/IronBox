import 'package:ironbox/src/models/questions.dart';

class TrainerQuestion {
  String id;
  String trainerId;
  String originalQuestionId;
  bool isOptional;
  Question originalQuestion;

  TrainerQuestion();

  TrainerQuestion.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      trainerId = jsonMap['trainer_id'] != null ? jsonMap['trainer_id'] : "";
      originalQuestionId =
          jsonMap['question_id'] != null ? jsonMap['question_id'] : "";
      isOptional = jsonMap['optional'] != null && jsonMap['optional'] == "0"
          ? false
          : true;
      originalQuestion = jsonMap['questions'] != null
          ? Question.fromJSON(jsonMap['questions'][0])
          : Question.fromJSON({});
    } catch (e) {
      print("Trainer Question Model Error: $e");
    }
  }
}
