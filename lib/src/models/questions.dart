import 'package:ironbox/src/models/question_option.dart';

class Question {
  String id;
  String statement;
  String addedBy;
  int category; // 1 = workout, 2 = diet
  int status;
  List<QuestionOption> optionsList;

  Question();

  Question.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      statement = jsonMap['statement'] != null ? jsonMap['statement'] : "";
      status = jsonMap['status'] != null ? int.parse(jsonMap['status']) : 0;
      addedBy = jsonMap['created_by'] != null ? jsonMap['created_by'] : "";
      category =
          jsonMap['category'] != null ? int.parse(jsonMap['category']) : 0;
      optionsList =
          jsonMap['options'] != null && (jsonMap['options'] as List).length > 0
              ? List.from(jsonMap['options'])
                  .map((element) => QuestionOption.fromJSON(element))
                  .toList()
              : [];
    } catch (e) {
      print("Question Model Error: $e");
    }
  }
}
