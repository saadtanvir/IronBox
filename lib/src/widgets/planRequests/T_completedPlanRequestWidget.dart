import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/planRequest.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

class TrainerCompletedPlanRequests extends StatefulWidget {
  List<PlanRequest> completedPlanRequestsList;
  TrainerCompletedPlanRequests(
      {Key key, @required this.completedPlanRequestsList})
      : super(key: key);

  @override
  _TrainerCompletedPlanRequestsState createState() =>
      _TrainerCompletedPlanRequestsState();
}

class _TrainerCompletedPlanRequestsState
    extends State<TrainerCompletedPlanRequests> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
