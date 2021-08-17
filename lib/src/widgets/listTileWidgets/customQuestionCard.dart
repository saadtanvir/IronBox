import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ironbox/src/models/questions.dart';
import 'package:get/get.dart';

class CustomQuestionCard extends StatelessWidget {
  final Question question;
  final bool canAdd;
  final bool canRemove;
  final Function addQuestion;
  final Function removeQuestion;
  var isQuestionAdded = false.obs;
  var isOptional = false.obs;
  CustomQuestionCard(
      {Key key,
      @required this.question,
      @required this.canAdd,
      @required this.canRemove,
      this.addQuestion,
      this.removeQuestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.zero,
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
            Text("${question.statement}"),
            const SizedBox(
              height: 5.0,
            ),
            question.optionsList.isNotEmpty
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
                          itemCount: question.optionsList.length,
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Text(
                              "- ${question.optionsList[index].optionStatement}",
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
                canAdd || canRemove
                    ? Obx(() {
                        return Checkbox(
                            value: isOptional.value,
                            activeColor: Colors.white,
                            checkColor: Theme.of(context).primaryColor,
                            onChanged: (value) {
                              isOptional.value = value;
                            });
                      })
                    : const SizedBox(
                        width: 0.0,
                        height: 0.0,
                      ),
                canAdd || canRemove
                    ? const Text(
                        "Optional",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox(
                        height: 0.0,
                        width: 0.0,
                      ),
                Spacer(),
                canAdd || canRemove
                    ? TextButton(
                        onPressed: () async {
                          if (isQuestionAdded.value) {
                            // call remove func
                            bool check = await removeQuestion(question.id);
                            if (check) {
                              Fluttertoast.showToast(
                                msg: "Question Removed",
                                backgroundColor: Colors.grey[600],
                              );
                              isQuestionAdded.value = false;
                            } else {
                              Fluttertoast.showToast(
                                msg: "Failed!",
                                backgroundColor: Colors.grey[600],
                              );
                            }
                          } else {
                            bool check = await addQuestion(
                                question.id, isOptional.value ? 1 : 0);
                            if (check) {
                              Fluttertoast.showToast(
                                msg: "Question Added",
                                backgroundColor: Colors.grey[600],
                              );
                              isQuestionAdded.value = true;
                            } else {
                              Fluttertoast.showToast(
                                msg: "Failed!",
                                backgroundColor: Colors.grey[600],
                              );
                            }
                          }
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
                        child: Obx(() {
                          return Text(
                            isQuestionAdded.value ? "Remove" : "Add",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          );
                        }),
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
