import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/planRequest.dart';
import 'package:ironbox/src/widgets/listTileWidgets/T_planRequestTile.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

class TrainerPendingPlanRequestsListWidget extends StatelessWidget {
  final List<PlanRequest> pendingRequestsList;
  final Function onRequestTap;
  const TrainerPendingPlanRequestsListWidget(
      {Key key,
      @required this.pendingRequestsList,
      @required this.onRequestTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: pendingRequestsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onRequestTap(pendingRequestsList[index]);
            },
            child: TrainerPlanRequestTile(request: pendingRequestsList[index]),
          );
        },
      ),
    );
  }
}
