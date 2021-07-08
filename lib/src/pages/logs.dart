import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:ironbox/src/controllers/logs_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/logs.dart';
import 'package:ironbox/src/widgets/showLogsWidget.dart';
import 'package:ironbox/src/widgets/showMessageIconWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/userLogForm.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;
import 'package:intl/intl.dart';

class LogsScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  LogsScreen({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _LogsScreenState createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  LogsController _con = Get.put(LogsController());
  TextEditingController _dateController = TextEditingController();
  GlobalKey<FormState> _logFormKey;
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
    _dateFormatter = DateFormat(Constants.dateStringFormat);
    _creationDate = _dateFormatter.format(DateTime.now());
    _calendarSelectedDate = _dateFormatter.format(DateTime.now());
    _con.calendarSelectedDate = _dateFormatter.format(DateTime.now());
    if (userRepo.currentUser.value.userToken != null) {
      _con.getUserLogs(userRepo.currentUser.value.id,
          date: _con.calendarSelectedDate);
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
            widget.parentScaffoldKey.currentState.openDrawer();
          },
        ),
        // actions: [
        //   MessageIconWidget(),
        // ],
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
                  _con.calendarSelectedDate =
                      _dateFormatter.format(selectedDate);
                  _con.getUserLogs(userRepo.currentUser.value.id,
                      date: _con.calendarSelectedDate);
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
                            "No logs for selected date !",
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
      onPressed: () async {
        var createdLog = await Get.to(
          UserLogForm(
              userRepo.currentUser.value.id, userRepo.currentUser.value.id),
          fullscreenDialog: true,
        );
        if (createdLog != null) {
          _con.addLog(createdLog);
        }
      },
      child: Icon(
        Icons.add,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
