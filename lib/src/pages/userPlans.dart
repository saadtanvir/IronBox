import 'package:fitness_app/src/controllers/plans_controller.dart';
import 'package:fitness_app/src/widgets/userPlansListWidget.dart';
import '../repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPlans extends StatefulWidget {
  final String category;
  final String title;
  UserPlans(this.category, this.title);
  @override
  _UserPlansState createState() => _UserPlansState();
}

class _UserPlansState extends State<UserPlans> {
  PlansController _con = Get.put(PlansController());

  @override
  void initState() {
    if (userRepo.currentUser.value.userToken != null) {
      _con.getUserPlansByCategory(
          widget.category, userRepo.currentUser.value.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.title} Plans",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Obx(() {
                return _con.plans.isEmpty && !_con.doneFetchingPlans.value
                    ? Center(child: CircularProgressIndicator())
                    : _con.plans.isEmpty && _con.doneFetchingPlans.value
                        ? Center(
                            child: Text(
                              "You have not bought any plan yet !",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : UserPlansListWidget(_con.plans);
              }),
            )
          ],
        ),
      ),
    );
  }
}
