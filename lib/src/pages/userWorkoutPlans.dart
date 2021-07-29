import '../controllers/plans_controller.dart';
import '../models/userWorkoutPlan.dart';
import '../pages/userWorkoutPlanDetails.dart';
import '../widgets/userPlansListWidget.dart';
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
        title: const Text("Workout Plans"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return _con.userWorkoutPlans.isEmpty &&
                      !_con.doneFetchingUserWorkoutPlans.value
                  ? const Center(
                      child: const CircularProgressIndicator(),
                    )
                  : _con.userWorkoutPlans.isEmpty &&
                          _con.doneFetchingUserWorkoutPlans.value
                      ? const Center(
                          child:
                              const Text("You have not bought any plan yet!"),
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
