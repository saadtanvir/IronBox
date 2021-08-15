import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/planRequest.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

class TrainerNewPlanRequestsWidget extends StatelessWidget {
  List<PlanRequest> newPlanRequestsList;
  TrainerNewPlanRequestsWidget({Key key, @required this.newPlanRequestsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: ListView.builder(
          itemCount: newPlanRequestsList.length,
          itemBuilder: (context, index) {
            return planRequestTile(newPlanRequestsList[index]);
          },
        ),
      ),
    );
  }

  Widget planRequestTile(PlanRequest request) {
    return ListTile(
      title: Text("Trainee name: ${request.trainee.name}"),
    );
  }
}
