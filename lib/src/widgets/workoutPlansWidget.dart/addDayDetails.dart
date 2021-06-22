import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDayDetails extends StatefulWidget {
  final int dayNumber;
  final int weekNumber;
  final String planId;
  AddDayDetails(
      {Key key,
      @required this.dayNumber,
      @required this.planId,
      @required this.weekNumber})
      : super(key: key);

  @override
  _AddDayDetailsState createState() => _AddDayDetailsState();
}

class _AddDayDetailsState extends State<AddDayDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Day Details"),
        centerTitle: true,
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
