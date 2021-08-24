import 'package:flutter/material.dart';
import 'package:ironbox/src/models/trainerQuestion.dart';
import 'package:ironbox/src/widgets/listTileWidgets/trainerQuestionCardWidget.dart';

class TrainerQuestionsList extends StatelessWidget {
  final List<TrainerQuestion> trainerQuestionsList;
  final bool canAdd;
  final bool canRemove;
  final Function onAdd;
  final Function onRemove;
  const TrainerQuestionsList(
      {Key key,
      @required this.trainerQuestionsList,
      @required this.canAdd,
      @required this.canRemove,
      this.onAdd,
      this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: trainerQuestionsList.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return TrainerQuestionCardWidget(
            question: trainerQuestionsList[index],
            canAdd: canAdd,
            canRemove: canRemove,
            onRemove: onRemove,
            onAdd: onAdd,
          );
        },
      ),
    );
  }
}
