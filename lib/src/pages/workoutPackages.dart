import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/models/workoutPlan.dart';
import 'package:ironbox/src/widgets/plansListWidget.dart';
import '../repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;

class WorkoutPackages extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  final String category;
  WorkoutPackages(this.category, {this.parentScaffoldKey});
  @override
  _WorkoutPackagesState createState() => _WorkoutPackagesState();
}

class _WorkoutPackagesState extends State<WorkoutPackages> {
  PlansController _con = Get.put(PlansController());

  void planOnTap(WorkoutPlan p) {
    // check if plan already subscribed or not
    // go to detailed or general profile accordingly
    _con.checkIsPlanSubscribed(
        context: context,
        uid: userRepo.currentUser.value.id,
        pid: p.id,
        workoutPlan: p);
  }

  void searchPlan(String searchString) {
    _con.searchPlan(searchString, widget.category);
  }

  @override
  void initState() {
    print("inside init of workout packages.dart");
    _con.getAllWorkoutPlans();
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
          children: [
            // SearchBarWidget(searchPlan),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() {
                return _con.workoutPlans.isEmpty &&
                        !_con.doneFetchingPlans.value
                    ? Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor),
                      )
                    : _con.workoutPlans.isEmpty && _con.doneFetchingPlans.value
                        ? const Center(
                            heightFactor: 10.0,
                            child: const Text(
                              "No plans to show !",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : PlansListWidget(
                            _con.workoutPlans.reversed.toList(), planOnTap);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
