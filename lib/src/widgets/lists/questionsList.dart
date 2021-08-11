import 'package:flutter/material.dart';
import 'package:ironbox/src/models/questions.dart';
import 'package:ironbox/src/widgets/listTileWidgets/customQuestionCard.dart';

class QuestionsList extends StatelessWidget {
  List<Question> questionsList;
  final bool canAddQuestion;
  final bool canRemoveQuestion;
  final Function addQuestion;
  final Function removeQuestion;
  QuestionsList(
      {Key key,
      @required this.questionsList,
      @required this.canAddQuestion,
      @required this.canRemoveQuestion,
      this.addQuestion,
      this.removeQuestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questionsList.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CustomQuestionCard(
            question: questionsList[index],
            canAdd: canAddQuestion,
            canRemove: canRemoveQuestion,
            addQuestion: addQuestion,
            removeQuestion: removeQuestion);
      },
    );
  }
}
