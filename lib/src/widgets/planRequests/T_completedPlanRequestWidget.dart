import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/planRequest.dart';
import 'package:ironbox/src/widgets/listTileWidgets/T_planRequestTile.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

class TrainerCompletedPlanRequestsListWidget extends StatelessWidget {
  final List<PlanRequest> completedPlanRequests;
  final Function onRequestTap;
  const TrainerCompletedPlanRequestsListWidget(
      {Key key,
      @required this.completedPlanRequests,
      @required this.onRequestTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: completedPlanRequests.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onRequestTap(completedPlanRequests[index]);
            },
            child:
                TrainerPlanRequestTile(request: completedPlanRequests[index]),
          );
        },
      ),
    );
  }
}
