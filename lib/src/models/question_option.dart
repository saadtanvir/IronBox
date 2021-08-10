import 'package:ironbox/src/models/questions.dart';

class QuestionOption {
  String id;
  String questionId;
  String optionStatement;

  QuestionOption();

  QuestionOption.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      questionId = jsonMap['question_id'] != null ? jsonMap['question_id'] : "";
      optionStatement = jsonMap['option_statement'] != null
          ? jsonMap['option_statement']
          : "";
    } catch (e) {
      print("Question Option Model Error: $e");
    }
  }
}
