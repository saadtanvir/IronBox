import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/models/userWorkoutPlan.dart';
import 'package:ironbox/src/models/userWorkoutPlanDetails.dart';
import 'package:ironbox/src/pages/userWorkoutPlanDetails.dart';
import 'package:ironbox/src/widgets/userPlansListWidget.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/childCategoriesList.dart';

import '../widgets/workoutPlansWidget.dart/subCategoriesList.dart';
import '../helpers/helper.dart';
import '../models/category.dart';
import '../pages/userPlans.dart';
import '../widgets/categoryCardWidget.dart';
import '../widgets/userSubscribedTrainers.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAllWorkoutPlans extends StatefulWidget {
  const UserAllWorkoutPlans({Key key}) : super(key: key);

  @override
  _UserAllWorkoutPlansState createState() => _UserAllWorkoutPlansState();
}

class _UserAllWorkoutPlansState extends State<UserAllWorkoutPlans> {
  PlansController _con = Get.put(PlansController());

  void onPlanTap(UserWorkoutPlan plan) {
    // go to details
    Get.to(
      ShowUserWorkoutPlanDetails(plan),
      transition: Transition.rightToLeft,
    );
  }

  @override
  void initState() {
    _con.getAllUserWorkoutPlans(userRepo.currentUser.value.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Plans"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return _con.userWorkoutPlans.isEmpty &&
                      !_con.doneFetchingUserWorkoutPlans.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _con.userWorkoutPlans.isEmpty &&
                          _con.doneFetchingUserWorkoutPlans.value
                      ? Center(
                          child: Text("You have not bought any plan yet!"),
                        )
                      : UserWorkoutPlansListWidget(
                          _con.userWorkoutPlans, onPlanTap);
            }),
          ],
        ),
      ),
    );
  }
}
