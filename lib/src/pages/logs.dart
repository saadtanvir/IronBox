import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:fitness_app/src/controllers/logs_controller.dart';
import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/models/logs.dart';
import 'package:fitness_app/src/widgets/showLogsWidget.dart';
import 'package:fitness_app/src/widgets/showMessageIconWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;
import 'package:intl/intl.dart';

class LogsScreen extends StatefulWidget {
  @override
  _LogsScreenState createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  LogsController _con = Get.put(LogsController());
  TextEditingController _dateController = TextEditingController();
  GlobalKey<FormState> _logFormKey;
  String dateFormat = "dd-MM-yyyy";
  DateFormat _dateFormatter;
  String _creationDate;
  String _calendarSelectedDate;

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

  void updateLogStatus(String logId, String status) {
    _con.updateLogStatus(id: logId, status: status);
  }

  void deleteLog(String logId) {
    _con.deleteLog(logId);
  }

  @override
  void initState() {
    _logFormKey = new GlobalKey<FormState>();
    _dateFormatter = DateFormat(dateFormat);
    _creationDate = _dateFormatter.format(DateTime.now());
    _calendarSelectedDate = _dateFormatter.format(DateTime.now());
    if (userRepo.currentUser.value.userToken != null) {
      _con.getUserLogs(userRepo.currentUser.value.id,
          date: _calendarSelectedDate);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Image(
          image: AssetImage("assets/img/logo_vertical.png"),
        ),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.notes_rounded,
              color: Theme.of(context).accentColor),
          onPressed: () {
            // open drawer from pages file
            // using parent key
          },
        ),
        actions: [
          MessageIconWidget(),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Helper.of(context).getScreenHeight() * 0.45,
              child: CalendarDatePicker(
                onDateChanged: (selectedDate) {
                  _calendarSelectedDate = _dateFormatter.format(selectedDate);
                  _con.getUserLogs(userRepo.currentUser.value.id,
                      date: _calendarSelectedDate);
                },
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 30)),
                lastDate: DateTime.now().add(Duration(days: 30)),
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Logs",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SizedBox(height: 5.0),
            Obx(() {
              return _con.logs.isEmpty && !_con.doneFetchingLogs.value
                  ? Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : _con.logs.isEmpty && _con.doneFetchingLogs.value
                      ? Center(
                          heightFactor: 10.0,
                          child: Text(
                            "No logs for current date !",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ShowLogsWidget(
                          logsList: _con.logs,
                          updateLogStatus: updateLogStatus,
                          deleteLog: deleteLog,
                        );
            }),
          ],
        ),
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.defaultDialog(
          title: "Create Task",
          titleStyle: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          content: Form(
            key: _logFormKey,
            child: Expanded(
              child: SingleChildScrollView(
                // scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.title,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _con.newLog.title = input,
                      validator: (input) =>
                          input.length < 1 ? "required" : null,
                      autofocus: true,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: Constants.taskTitle,
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.description,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _con.newLog.description = input,
                      validator: (input) =>
                          input.length < 1 ? "required" : null,
                      autofocus: true,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: Constants.task_desc,
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.due_date,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: _dateController,
                      keyboardType: TextInputType.datetime,
                      onSaved: (input) => _con.newLog.dueDate = input,
                      validator: (input) =>
                          input.length < 1 ? "required" : null,
                      readOnly: true,
                      autofocus: false,
                      onTap: () {
                        _handleDate();
                      },
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "17 August 2020",
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.taskTime,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (input) =>
                          _con.newLog.duration = input.toString(),
                      validator: (input) =>
                          input.length < 1 ? "required" : null,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "in minutes",
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 3,
                    //       child: Text(
                    //         Constants.get_alert_for_this_task,
                    //         style: TextStyle(
                    //           color: Theme.of(context).scaffoldBackgroundColor,
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //         flex: 1,
                    //         child: Obx(() {
                    //           return CupertinoSwitch(
                    //             onChanged: (value) {
                    //               _con.getAlert.value = value;
                    //             },
                    //             value: _con.getAlert.value,
                    //           );
                    //         }))
                    //   ],
                    // ),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextButton(
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (!_logFormKey.currentState.validate()) {
                          return;
                        } else if (_logFormKey.currentState.validate()) {
                          if (userRepo.currentUser.value.id != null) {
                            _con.newLog.isCompleted = 0;
                            _con.newLog.userId = userRepo.currentUser.value.id;
                            _con.newLog.createdBy =
                                userRepo.currentUser.value.id;
                            _logFormKey.currentState.save();
                            _con.addLog();
                          }
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 50.0),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).scaffoldBackgroundColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                      ),
                      child: Text(
                        Constants.create_a_task,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Icon(
        Icons.add,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
