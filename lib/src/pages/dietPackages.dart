import 'package:fitness_app/src/widgets/searchBarWidget.dart';
import 'package:fitness_app/src/widgets/trainingPlansWidget.dart';
import 'package:flutter/material.dart';
import '../helpers/app_constants.dart' as Constants;

class DietPackages extends StatefulWidget {
  @override
  _DietPackagesState createState() => _DietPackagesState();
}

class _DietPackagesState extends State<DietPackages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: new IconButton(
          icon: new Icon(Icons.notes_rounded,
              color: Theme.of(context).accentColor),
          onPressed: () {
            // open drawer from pages file
            // using parent key
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBarWidget(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TrainingPlansWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
