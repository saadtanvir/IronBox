import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/gamesListWidget.dart';
import '../../helpers/app_constants.dart' as Constants;

class AddWorkoutPlanGameDialog extends StatelessWidget {
  Map<String, String> gameData = {};
  GlobalKey<FormState> _workoutPlanGameFormKey = new GlobalKey<FormState>();
  AddWorkoutPlanGameDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300.0,
        width: 250.0,
        margin: EdgeInsets.all(20.0),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(1.0)),
        // ),
        child: Form(
          key: _workoutPlanGameFormKey,
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
                SizedBox(
                  height: 0.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (input) => gameData['name'] = input,
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: Constants.super_set,
                    hintStyle: TextStyle(
                      fontSize: 12.0,
                      color: Theme.of(context).accentColor.withOpacity(0.3),
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                SizedBox(
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
                            Constants.no_of_sets + ":",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 0.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (input) => gameData['sets'] = input,
                            validator: (input) =>
                                input.length < 1 ? "required" : null,
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
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: 10.0,
                    // ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         Constants.no_of_rounds + ":",
                    //         style: TextStyle(
                    //           color: Theme.of(context).accentColor,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 0.0,
                    //       ),
                    //       TextFormField(
                    //         keyboardType: TextInputType.number,
                    //         onSaved: (input) => gameData['rounds'] = input,
                    //         validator: (input) =>
                    //             input.length < 1 ? "required" : null,
                    //         decoration: InputDecoration(
                    //           floatingLabelBehavior:
                    //               FloatingLabelBehavior.never,
                    //           hintText: "2",
                    //           hintStyle: TextStyle(
                    //             fontSize: 12.0,
                    //             color: Theme.of(context)
                    //                 .accentColor
                    //                 .withOpacity(0.3),
                    //           ),
                    //           contentPadding: EdgeInsets.all(10),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      // get.back and send data map
                      if (!_workoutPlanGameFormKey.currentState.validate()) {
                        return;
                      } else if (_workoutPlanGameFormKey.currentState
                          .validate()) {
                        _workoutPlanGameFormKey.currentState.save();
                        Get.back(result: gameData);
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 30.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      overlayColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor.withOpacity(0.3),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
    );
  }
}
