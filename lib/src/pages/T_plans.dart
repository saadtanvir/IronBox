import '../models/category.dart';
import '../models/workoutPlan.dart';
import '../widgets/T_createPlanWidget.dart';
import '../controllers/plans_controller.dart';
import '../widgets/showWOPTrainer/showWorkoutPlanToTrainer.dart';
import '../widgets/workoutPlansWidget.dart/trainerWorkoutPlansList.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerPlans extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  TrainerPlans({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _TrainerPlansState createState() => _TrainerPlansState();
}

class _TrainerPlansState extends State<TrainerPlans> {
  PlansController _con = Get.put(PlansController());

  void planOnTap(WorkoutPlan p) {
    Get.to(
      ShowWorkoutPlanToTrainer(p),
      transition: Transition.rightToLeft,
    );
  }

  @override
  void initState() {
    _con.getChildCategories();
    _con.getSubCategories();
    _con.listenForCategories();
    if (userRepo.currentUser.value.userToken != null) {
      _con.getTrainerWorkoutPlans(userRepo.currentUser.value.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Workout Plans",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        // title: Image(
        //   image: AssetImage("assets/img/logo_vertical.png"),
        // ),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.notes_rounded,
              color: Theme.of(context).accentColor),
          onPressed: () {
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
          children: [
            // pass onSubmit func
            // update the widget below
            // SearchBarWidget(),
            Obx(() {
              return _con.trainerWorkoutPlansList.isEmpty &&
                      !_con.doneFetchingPlans.value
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor),
                      ),
                    )
                  : _con.trainerWorkoutPlansList.isEmpty &&
                          _con.doneFetchingPlans.value
                      ? const Center(
                          heightFactor: 20.0,
                          child: const Text(
                            "You have not created any plan yet !",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : TrainerWorkoutPlansList(
                          _con.trainerWorkoutPlansList, planOnTap);
            }),
          ],
        ),
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        if (Constants.appCategories.length > 0) {
          // print(Constants.appCategories.where((Category cat) {
          //   return cat.name == "Workout";
          // }));
          Category workoutCategory =
              Constants.appCategories.firstWhere((Category cat) {
            return cat.name == "Workout";
          });
          Get.to(
            TrainerCreatePlanWidget(
              mainCategoryId: workoutCategory.id,
            ),
            fullscreenDialog: true,
            transition: Transition.downToUp,
            duration: new Duration(milliseconds: 500),
          );
          // Get.dialog(SelectPlanCategoryDialog(Constants.appCategories));
        }
      },
      child: Icon(
        Icons.add,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      splashColor: Theme.of(context).accentColor.withOpacity(0.5),
    );
  }
}
