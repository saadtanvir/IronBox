import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/models/plan.dart';
import 'package:ironbox/src/pages/appPlanDetails.dart';
import 'package:ironbox/src/widgets/plansListWidget.dart';
import 'package:ironbox/src/widgets/searchBarWidget.dart';
import 'package:ironbox/src/widgets/trainingPlansWidget.dart';
import 'package:ironbox/src/widgets/showMessageIconWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;

class TrainingPackages extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  final String category;
  TrainingPackages(this.category, {this.parentScaffoldKey});
  @override
  _TrainingPackagesState createState() => _TrainingPackagesState();
}

class _TrainingPackagesState extends State<TrainingPackages> {
  PlansController _con = Get.put(PlansController());

  void planOnTap(Plan p) {
    Get.to(AppPlanDetails(p));
  }

  void searchPlan(String searchString) {
    _con.searchPlan(searchString, widget.category);
  }

  @override
  void initState() {
    print("inside init of training packages.dart");
    _con.getPlansByCategory(widget.category);
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
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SearchBarWidget(
              searchPlan,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() {
                return _con.plans.isEmpty && !_con.doneFetchingPlans.value
                    ? CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor)
                    : _con.plans.isEmpty && _con.doneFetchingPlans.value
                        ? Center(
                            heightFactor: 10.0,
                            child: Text(
                              "No plans to show",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : PlansListWidget(
                            _con.plans.reversed.toList(), planOnTap);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
