import 'package:fitness_app/src/controllers/plans_controller.dart';
import 'package:fitness_app/src/widgets/plansListWidget.dart';
import 'package:fitness_app/src/widgets/searchBarWidget.dart';
import 'package:fitness_app/src/widgets/trainingPlansWidget.dart';
import 'package:fitness_app/src/widgets/showMessageIconWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;

class TrainingPackages extends StatefulWidget {
  final String name;
  TrainingPackages(this.name);
  @override
  _TrainingPackagesState createState() => _TrainingPackagesState();
}

class _TrainingPackagesState extends State<TrainingPackages> {
  PlansController _con = Get.put(PlansController());

  @override
  void initState() {
    print("inside init of training packages.dart");
    _con.getPlansByCategory(widget.name);
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
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SearchBarWidget(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() {
                return _con.plans.isEmpty
                    ? CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor)
                    : PlansListWidget(_con.plans);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
