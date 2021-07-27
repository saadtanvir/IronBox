import '../controllers/logs_controller.dart';
import '../helpers/helper.dart';
import '../models/logs.dart';
import '../widgets/showLogsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/userLogForm.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;
import 'package:intl/intl.dart';

class LogsScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  final bool canDelete;
  final bool canUpdate;
  final String logUserId;
  LogsScreen(
      {Key key,
      this.parentScaffoldKey,
      this.canDelete,
      this.canUpdate,
      this.logUserId})
      : super(key: key);
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

  void deleteLog(Logs log) {
    _con.deleteLog(log.id);
  }

  @override
  void initState() {
    _logFormKey = new GlobalKey<FormState>();
    _dateFormatter = DateFormat(Constants.dateStringFormat);
    _creationDate = _dateFormatter.format(DateTime.now());
    _calendarSelectedDate = _dateFormatter.format(DateTime.now());
    _con.calendarSelectedDate = _dateFormatter.format(DateTime.now());
    _con.getUserLogs(widget.logUserId ?? userRepo.currentUser.value.id,
        date: _con.calendarSelectedDate);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Image(
          image: AssetImage("assets/img/logo_vertical.png"),
        ),
        centerTitle: true,
        leading: widget.parentScaffoldKey != null
            ? new IconButton(
                icon: new Icon(Icons.notes_rounded,
                    color: Theme.of(context).accentColor),
                onPressed: () {
                  // open drawer from pages file
                  // using parent key
                  widget.parentScaffoldKey.currentState.openDrawer();
                },
              )
            : IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
                color: Theme.of(context).primaryColor,
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
                  _con.getUserLogs(
                      widget.logUserId ?? userRepo.currentUser.value.id,
                      date: _con.calendarSelectedDate);
                },
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 30)),
                lastDate: DateTime.now().add(Duration(days: 30)),
              ),
            ),
            const SizedBox(height: 5.0),
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
                  ? const Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: const Center(
                        child: const CircularProgressIndicator(),
                      ),
                    )
                  : _con.logs.isEmpty && _con.doneFetchingLogs.value
                      ? const Center(
                          heightFactor: 10.0,
                          child: const Text(
                            "No logs for selected date !",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ShowLogsWidget(
                          canDelete: widget.canDelete ?? true,
                          canUpdate: widget.canUpdate ?? true,
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
          UserLogForm(widget.logUserId ?? userRepo.currentUser.value.id,
              userRepo.currentUser.value.id),
          fullscreenDialog: true,
        );
        print(createdLog);
        if (createdLog != null) {
          if (createdLog.title.isNotEmpty) {
            print(createdLog.dueDate);

            _con.createUserLog(createdLog);
          }
        }
      },
      child: Icon(
        Icons.add,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
