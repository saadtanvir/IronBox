import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plan_request_controller.dart';
import 'package:ironbox/src/models/planRequest.dart';
import 'package:ironbox/src/pages/T_planRequestDetailsPage.dart';
import 'package:ironbox/src/widgets/planRequests/T_completedPlanRequestWidget.dart';
import 'package:ironbox/src/widgets/planRequests/T_newPlanRequestsWidget.dart';
import 'package:ironbox/src/widgets/planRequests/T_pendingPlanRequestsWidget.dart';
import 'package:ironbox/src/widgets/planRequests/T_rejectedPlanRequestsWidget.dart';
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

  void onRequestTap(PlanRequest request) {
    // go on request details
    Get.to(
      TrainerPlanRequestDetailsPage(request: request),
      transition: Transition.rightToLeft,
    );
  }

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
          children: [
            Obx(() {
              return _con.trainerNewPlanRequests.isEmpty &&
                      !_con.doneFetchingRequests.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _con.trainerNewPlanRequests.isEmpty &&
                          _con.doneFetchingRequests.value
                      ? Center(
                          child: Text("No new requests!"),
                        )
                      : TrainerNewPlanRequestsWidget(
                          newPlanRequestsList: _con.trainerNewPlanRequests,
                          onRequestTap: onRequestTap,
                        );
            }),
            Obx(() {
              return _con.trainerPendingPlanRequests.isEmpty &&
                      !_con.doneFetchingRequests.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _con.trainerPendingPlanRequests.isEmpty &&
                          _con.doneFetchingRequests.value
                      ? Center(
                          child: Text("No pending requests!"),
                        )
                      : TrainerPendingPlanRequestsListWidget(
                          pendingRequestsList: _con.trainerPendingPlanRequests,
                          onRequestTap: onRequestTap,
                        );
            }),
            Obx(() {
              return _con.trainerCompletedPlanRequests.isEmpty &&
                      !_con.doneFetchingRequests.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _con.trainerPendingPlanRequests.isEmpty &&
                          _con.doneFetchingRequests.value
                      ? Center(
                          child: Text("No completed request!"),
                        )
                      : TrainerCompletedPlanRequestsListWidget(
                          completedPlanRequests:
                              _con.trainerCompletedPlanRequests,
                          onRequestTap: onRequestTap,
                        );
            }),
            Obx(() {
              return _con.trainerRejectedPlanRequests.isEmpty &&
                      !_con.doneFetchingRequests.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _con.trainerRejectedPlanRequests.isEmpty &&
                          _con.doneFetchingRequests.value
                      ? Center(
                          child: Text("No rejected request!"),
                        )
                      : TrainerRejectedPlanRequestsListWidget(
                          rejectedRequestsList:
                              _con.trainerRejectedPlanRequests,
                          onRequestTap: onRequestTap,
                        );
            }),
          ],
        ),
      ),
    );
  }
}
