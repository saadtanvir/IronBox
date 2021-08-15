import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/planRequest.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

class TrainerRejectedPlanRequests extends StatefulWidget {
  List<PlanRequest> rejectedPlanRequestsList;
  TrainerRejectedPlanRequests(
      {Key key, @required this.rejectedPlanRequestsList})
      : super(key: key);

  @override
  _TrainerRejectedPlanRequestsState createState() =>
      _TrainerRejectedPlanRequestsState();
}

class _TrainerRejectedPlanRequestsState
    extends State<TrainerRejectedPlanRequests> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
