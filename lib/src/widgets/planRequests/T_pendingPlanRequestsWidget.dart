import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/planRequest.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

class TrainerPendingPlanRequests extends StatefulWidget {
  List<PlanRequest> pendingPlanRequestsList;
  TrainerPendingPlanRequests({Key key, @required this.pendingPlanRequestsList})
      : super(key: key);

  @override
  _TrainerPendingPlanRequestsState createState() =>
      _TrainerPendingPlanRequestsState();
}

class _TrainerPendingPlanRequestsState
    extends State<TrainerPendingPlanRequests> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
