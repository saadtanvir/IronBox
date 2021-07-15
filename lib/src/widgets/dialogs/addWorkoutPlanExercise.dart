import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/pages/showVideoLib.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/gamesListWidget.dart';
import '../../helpers/app_constants.dart' as Constants;

class AddWorkoutPlanExerciseWidget extends StatelessWidget {
  Map<String, String> exerciseData = {};
  GlobalKey<FormState> _workoutPlanExerciseFormKey = new GlobalKey<FormState>();
  var _videoUrlTextFieldController = new TextEditingController().obs;
  String selectedVideoUrl = "";
  AddWorkoutPlanExerciseWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Exercise"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _workoutPlanExerciseFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Constants.name + ":",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 0.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (input) => exerciseData['name'] = input,
                    validator: (input) => input.length < 1 ? "required" : null,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: Constants.push_ups,
                      hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Theme.of(context).accentColor.withOpacity(0.3),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    Constants.description + ":",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 0.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (input) => exerciseData['description'] = input,
                    validator: (input) => input.length < 1 ? "required" : null,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: Constants.description,
                      hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Theme.of(context).accentColor.withOpacity(0.3),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Constants.select_video + ":",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Obx(() {
                    return TextFormField(
                      controller: _videoUrlTextFieldController.value,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      onSaved: (input) => selectedVideoUrl.isNotEmpty
                          ? exerciseData['videoLink'] = input
                          : "",
                      // validator: (input) {
                      //   print(input);
                      //   return !input.contains(Helper.youtubeUrlRegExp())
                      //       ? "Not a valid youtube URL"
                      //       : null;
                      // },
                      decoration: InputDecoration(
                        labelText: Constants.supporting_video_url,
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                        hintText: Constants.youtube_your_video,
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).accentColor.withOpacity(0.3),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            // open bottom sheet
                            // show list of all videos from video lib
                            // on tap send video object back to screen
                            var data = await Get.to(
                              VideoLib(),
                              fullscreenDialog: true,
                            );
                            print(data.link);
                            _videoUrlTextFieldController.value.text = data.name;
                            selectedVideoUrl = data.link;
                          },
                          icon: const Icon(Icons.arrow_drop_down),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.0,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Constants.no_of_reps + ":",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 0.0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onSaved: (input) => input.isNotEmpty
                                  ? exerciseData['reps'] = input
                                  : "",
                              // validator: (input) =>
                              //     input.length < 1 ? "required" : null,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: "5",
                                hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.3),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Constants.duration_in_min + ":",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 0.0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onSaved: (input) =>
                                  exerciseData['duration'] = input,
                              validator: (input) =>
                                  input.length < 1 ? "required" : null,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: "15",
                                hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.3),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());

                        if (!_workoutPlanExerciseFormKey.currentState
                            .validate()) {
                          return;
                        } else if (_workoutPlanExerciseFormKey.currentState
                            .validate()) {
                          _workoutPlanExerciseFormKey.currentState.save();
                          Get.back(result: exerciseData);
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        overlayColor: MaterialStateProperty.all(
                          Theme.of(context).accentColor.withOpacity(0.3),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                      ),
                      child: Text(
                        Constants.add,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
