import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/plan_request_controller.dart';
import 'package:ironbox/src/models/planRequest.dart';
import 'package:ironbox/src/pages/T_editPlanQuestions.dart';
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
  PlanRequestController _con = Get.put(PlanRequestController(),
      tag: Constants.trainerEditCustomPlanQuestions);
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

  List<PopupMenuItem> menuOptions = [
    PopupMenuItem(
      value: 0,
      // padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Text(
        "Questions",
      ),
    ),
  ];

  void onRequestTap(PlanRequest request) {
    // go on request details
    Get.to(
      TrainerPlanRequestDetailsPage(
        request: request,
        onAccept: onRequestAccept,
      ),
      transition: Transition.rightToLeft,
    );
  }

  void onRequestAccept(PlanRequest request, String status) async {
    // change status to 2
    await _con.changePlanRequestStatus(context, request.id, status);
    // print("done");
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
          actions: [
            PopupMenuButton(
              onSelected: (itemIndex) {
                print(itemIndex);
                switch (itemIndex) {
                  case 0:
                    {
                      // show trainer questions
                      Get.to(
                        TrainerEditPlanQuestions(),
                        transition: Transition.rightToLeft,
                      );
                    }
                    break;
                  default:
                    {
                      print("not a valid option selected");
                    }
                }
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              elevation: 10.0,
              offset: Offset(0, 40),
              itemBuilder: (context) => menuOptions.map((item) {
                return item;
              }).toList(),
            ),
          ],
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
                          child: TextButton(
                            onPressed: () {
                              _con.refreshPlanRequests(
                                  userRepo.currentUser.value.id);
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              overlayColor: MaterialStateProperty.all(
                                Theme.of(context).accentColor.withOpacity(0.3),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            child: Text(
                              "No new request !\nTap to refresh",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () {
                            return _con.refreshPlanRequests(
                                userRepo.currentUser.value.id);
                          },
                          child: TrainerNewPlanRequestsWidget(
                            newPlanRequestsList: _con.trainerNewPlanRequests,
                            onRequestTap: onRequestTap,
                          ),
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
                          child: TextButton(
                            onPressed: () {
                              _con.refreshPlanRequests(
                                  userRepo.currentUser.value.id);
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              overlayColor: MaterialStateProperty.all(
                                Theme.of(context).accentColor.withOpacity(0.3),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            child: Text(
                              "No pending request !\nTap to refresh",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () {
                            return _con.refreshPlanRequests(
                                userRepo.currentUser.value.id);
                          },
                          child: TrainerPendingPlanRequestsListWidget(
                            pendingRequestsList:
                                _con.trainerPendingPlanRequests,
                            onRequestTap: onRequestTap,
                          ),
                        );
            }),
            Obx(() {
              return _con.trainerCompletedPlanRequests.isEmpty &&
                      !_con.doneFetchingRequests.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _con.trainerCompletedPlanRequests.isEmpty &&
                          _con.doneFetchingRequests.value
                      ? Center(
                          child: TextButton(
                            onPressed: () {
                              _con.refreshPlanRequests(
                                  userRepo.currentUser.value.id);
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              overlayColor: MaterialStateProperty.all(
                                Theme.of(context).accentColor.withOpacity(0.3),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            child: Text(
                              "No completed request !\nTap to refresh",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () {
                            return _con.refreshPlanRequests(
                                userRepo.currentUser.value.id);
                          },
                          child: TrainerCompletedPlanRequestsListWidget(
                            completedPlanRequests:
                                _con.trainerCompletedPlanRequests,
                            onRequestTap: onRequestTap,
                          ),
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
                          child: TextButton(
                            onPressed: () {
                              _con.refreshPlanRequests(
                                  userRepo.currentUser.value.id);
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              overlayColor: MaterialStateProperty.all(
                                Theme.of(context).accentColor.withOpacity(0.3),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            child: Text(
                              "No rejected request !\nTap to refresh",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () {
                            return _con.refreshPlanRequests(
                                userRepo.currentUser.value.id);
                          },
                          child: TrainerRejectedPlanRequestsListWidget(
                            rejectedRequestsList:
                                _con.trainerRejectedPlanRequests,
                            onRequestTap: onRequestTap,
                          ),
                        );
            }),
          ],
        ),
      ),
    );
  }
}
