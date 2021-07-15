import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:ironbox/src/controllers/logs_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/logs.dart';
import 'package:ironbox/src/pages/showVideoLib.dart';
import 'package:ironbox/src/widgets/showLogsWidget.dart';
import 'package:ironbox/src/widgets/showMessageIconWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;
import 'package:intl/intl.dart';

class UserLogForm extends StatefulWidget {
  final String logUserId;
  final String currentUserId;
  UserLogForm(this.logUserId, this.currentUserId, {Key key}) : super(key: key);

  @override
  _UserLogFormState createState() => _UserLogFormState();
}

class _UserLogFormState extends State<UserLogForm> {
  Logs log = new Logs();
  GlobalKey<FormState> _logFormKey;
  TextEditingController _dateController = TextEditingController();
  var _videoUrlTextFieldController =
      new TextEditingController(text: "Select Video").obs;

  var categoryId = 0.obs;

  DateFormat _dateFormatter;
  String _creationDate;

  var categoryRadioTileGroupValue = 0.obs;

  _handleDate() async {
    print("open calendar");
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(new Duration(days: 30)));

    if (date != null) {
      setState(() {
        _creationDate = _dateFormatter.format(date);
        _dateController.text = _creationDate;
      });
    }
  }

  @override
  void initState() {
    _logFormKey = new GlobalKey<FormState>();
    _dateFormatter = DateFormat(Constants.dateStringFormat);
    _creationDate = _dateFormatter.format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Log",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _logFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Constants.title,
                    style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (input) => log.title = input,
                  validator: (input) => input.length < 1 ? "required" : null,
                  autofocus: false,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: "running",
                    hintStyle: TextStyle(
                      fontSize: 12.0,
                      // fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor.withOpacity(0.5),
                    ),
                    errorStyle: TextStyle(color: Colors.white),
                    // contentPadding: EdgeInsets.all(5),
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     width: 0.0,
                    //   ),
                    //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    // ),
                  ),
                ),
                SizedBox(height: 30.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Constants.description,
                    style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (input) => log.description = input,
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: Constants.task_desc,
                    hintStyle: TextStyle(
                      fontSize: 12.0,
                      // fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor.withOpacity(0.5),
                    ),
                    errorStyle: TextStyle(color: Colors.white),
                    // contentPadding: EdgeInsets.all(10),
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     width: 0.0,
                    //   ),
                    //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    // ),
                  ),
                ),
                SizedBox(height: 30.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Constants.due_date,
                    style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _dateController,
                  keyboardType: TextInputType.datetime,
                  onSaved: (input) => log.dueDate = input,
                  validator: (input) => input.length < 1 ? "required" : null,
                  readOnly: true,
                  onTap: () {
                    _handleDate();
                  },
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: "17 August 2020",
                    hintStyle: TextStyle(
                      fontSize: 12.0,
                      // fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor.withOpacity(0.5),
                    ),
                    errorStyle: TextStyle(color: Colors.white),
                    // contentPadding: EdgeInsets.all(10),
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     width: 0.0,
                    //   ),
                    //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    // ),
                  ),
                ),
                SizedBox(height: 30.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Constants.taskTime,
                    style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (input) => log.duration = input.toString(),
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "enter duration in minutes",
                    labelStyle: TextStyle(
                      fontSize: 12.0,
                      color: Theme.of(context).accentColor.withOpacity(0.5),
                    ),
                    errorStyle: TextStyle(color: Colors.white),
                    // contentPadding: EdgeInsets.all(10),
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     width: 0.0,
                    //   ),
                    //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    // ),
                  ),
                ),
                SizedBox(height: 30.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Supporting Video",
                    style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(() {
                  return TextFormField(
                    controller: _videoUrlTextFieldController.value,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    onSaved: (input) => log.videoUrl = input,
                    // validator: (input) {
                    //   print(input);
                    //   return !input.contains(Helper.youtubeUrlRegExp())
                    //       ? "Not a valid youtube URL"
                    //       : null;
                    // },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: Constants.supporting_video_url,
                      labelStyle: TextStyle(
                        fontSize: 12.0,
                        // fontWeight: FontWeight.bold,
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
                            transition: Transition.downToUp,
                          );
                          print(data.link);
                          _videoUrlTextFieldController.value.text = data.link;
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                        ),
                      ),
                      // contentPadding: EdgeInsets.all(10),
                      // border: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //     width: 0.0,
                      //   ),
                      //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      // ),
                    ),
                  );
                }),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        return RadioListTile(
                          value: 1,
                          groupValue: categoryRadioTileGroupValue.value,
                          title: Text("Workout"),
                          // subtitle: Text("Weeks"),
                          activeColor: Theme.of(context).primaryColor,
                          selected: categoryRadioTileGroupValue.value == 1
                              ? true
                              : false,
                          onChanged: (val) {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            categoryRadioTileGroupValue.value = val;
                            log.categoryId = val;
                            categoryId.value = val;
                          },
                        );
                      }),
                    ),
                    Expanded(
                      child: Obx(() {
                        return RadioListTile(
                          value: 2,
                          groupValue: categoryRadioTileGroupValue.value,
                          title: Text("Diet"),
                          // subtitle: Text("Weeks"),
                          activeColor: Theme.of(context).primaryColor,
                          selected: categoryRadioTileGroupValue.value == 2
                              ? true
                              : false,
                          onChanged: (val) {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            categoryRadioTileGroupValue.value = val;
                            log.categoryId = val;
                            categoryId.value = val;
                          },
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Obx(() {
                  return categoryId.value == 1
                      ? Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reps:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onSaved: (input) =>
                                        log.reps = int.parse(input),
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
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Calories Burn",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onSaved: (input) =>
                                        log.calBurn = int.parse(input),
                                    validator: (input) =>
                                        input.length < 1 ? "required" : null,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      hintText: "30",
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
                          ],
                        )
                      : categoryId.value == 2
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Calories Gain",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  onSaved: (input) =>
                                      log.calGain = int.parse(input),
                                  validator: (input) =>
                                      input.length < 1 ? "required" : null,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintText: "50",
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
                            )
                          : SizedBox(
                              height: 0.0,
                              width: 0.0,
                            );
                }),
                SizedBox(
                  height: 40.0,
                ),
                TextButton(
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (!_logFormKey.currentState.validate() ||
                        categoryId.value == 0) {
                      return;
                    } else if (_logFormKey.currentState.validate()) {
                      _logFormKey.currentState.save();
                      log.isCompleted = 0;
                      log.userId = widget.logUserId;
                      log.createdBy = widget.currentUserId;
                      Get.back(result: log);
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50.0),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  ),
                  child: Text(
                    Constants.create_a_task,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
