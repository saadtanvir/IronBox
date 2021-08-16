import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/planRequest.dart';
import 'package:ironbox/src/widgets/listTileWidgets/T_planRequestTile.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

class TrainerRejectedPlanRequestsListWidget extends StatelessWidget {
  final List<PlanRequest> rejectedRequestsList;
  final Function onRequestTap;
  const TrainerRejectedPlanRequestsListWidget(
      {Key key,
      @required this.rejectedRequestsList,
      @required this.onRequestTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: rejectedRequestsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onRequestTap(rejectedRequestsList[index]);
            },
            child: TrainerPlanRequestTile(request: rejectedRequestsList[index]),
          );
        },
      ),
    );
  }
}
