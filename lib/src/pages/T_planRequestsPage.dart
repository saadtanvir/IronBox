import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plan_request_controller.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/widgets/planRequests/T_newPlanRequestsWidget.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;

class TrainerPlanRequestsPage extends StatefulWidget {
  const TrainerPlanRequestsPage({Key key}) : super(key: key);

  @override
  _TrainerPlanRequestsPageState createState() =>
      _TrainerPlanRequestsPageState();
}

class _TrainerPlanRequestsPageState extends State<TrainerPlanRequestsPage> {
  PlanRequestController _con = Get.put(PlanRequestController());
  List<Tab> planRequestTypes = [
    Tab(
      text: "New",
    ),
    Tab(
      text: "Pending",
    ),
    Tab(
      text: "Completed",
    ),
    Tab(
      text: "Rejected",
    ),
  ];

  @override
  void initState() {
    _con.getTrainerPlanRequests(userRepo.currentUser.value.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: planRequestTypes.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Requests"),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: planRequestTypes,
          ),
        ),
        body: TabBarView(
          // physics: NeverScrollableScrollPhysics(),
          children: [
            Obx(() {
              return _con.trainerNewPlanRequests.isEmpty &&
                      !_con.doneFetchingRequests.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _con.trainerNewPlanRequests.isEmpty &&
                          _con.doneFetchingRequests.value
                      ? Center(child: Text("No new requests!"))
                      : TrainerNewPlanRequestsWidget(
                          newPlanRequestsList: _con.trainerNewPlanRequests);
            }),
            Text("Pending"),
            Text("Completed"),
            Text("Rejected"),
          ],
        ),
      ),
    );
  }
}
