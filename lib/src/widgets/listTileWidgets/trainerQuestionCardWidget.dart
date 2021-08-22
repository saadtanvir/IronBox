import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/trainerQuestion.dart';

class TrainerQuestionCardWidget extends StatelessWidget {
  final TrainerQuestion question;
  final bool canRemove;
  final bool canAdd;
  final Function onRemove;
  final Function onAdd;
  // var isQuestionAdded = false.obs;
  // var isOptional = false.obs;
  TrainerQuestionCardWidget(
      {Key key,
      @required this.question,
      @required this.canAdd,
      @required this.canRemove,
      this.onAdd,
      this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[400],
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Question:",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text("${question.originalQuestion.statement}"),
            const SizedBox(
              height: 5.0,
            ),
            question.originalQuestion.optionsList.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Options:",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        height: 100.0,
                        child: ListView.separated(
                          itemCount:
                              question.originalQuestion.optionsList.length,
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Text(
                              "- ${question.originalQuestion.optionsList[index].optionStatement}",
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 2.0,
                              height: 20.0,
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 0.0,
                    width: 0.0,
                  ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // canAdd || canRemove
                //     ? Obx(() {
                //         return Checkbox(
                //             value: isOptional.value,
                //             activeColor: Colors.white,
                //             checkColor: Theme.of(context).primaryColor,
                //             onChanged: (value) {
                //               isOptional.value = value;
                //             });
                //       })
                //     : const SizedBox(
                //         width: 0.0,
                //         height: 0.0,
                //       ),
                // canAdd || canRemove
                //     ? const Text(
                //         "Optional",
                //         style: TextStyle(
                //           color: Colors.white,
                //         ),
                //       )
                //     : const SizedBox(
                //         height: 0.0,
                //         width: 0.0,
                //       ),
                // const Spacer(),
                canAdd || canRemove
                    ? TextButton(
                        onPressed: () async {
                          onRemove(question);
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 5.0),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          overlayColor: MaterialStateProperty.all(
                            Theme.of(context).accentColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                        child: Text(
                          canRemove ? "Remove" : "Add",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 0.0,
                        width: 0.0,
                      ),
                const SizedBox(
                  width: 5.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
