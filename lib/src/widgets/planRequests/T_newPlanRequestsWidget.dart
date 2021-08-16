import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/planRequest.dart';
import 'package:ironbox/src/widgets/listTileWidgets/T_planRequestTile.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

class TrainerNewPlanRequestsWidget extends StatelessWidget {
  List<PlanRequest> newPlanRequestsList;
  Function onRequestTap;
  TrainerNewPlanRequestsWidget(
      {Key key,
      @required this.newPlanRequestsList,
      @required this.onRequestTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: newPlanRequestsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onRequestTap(newPlanRequestsList[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  TrainerPlanRequestTile(request: newPlanRequestsList[index]),
            ),
          );
        },
      ),
    );
  }
}
