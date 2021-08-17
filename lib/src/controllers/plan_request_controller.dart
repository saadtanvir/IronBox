import 'package:flutter/material.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/planRequest.dart';
import '../repositories/plan_request_repo.dart' as planRequestRepo;
import '../helpers/app_constants.dart' as Constants;
import 'package:get/get.dart';

class PlanRequestController extends GetxController {
  var trainerPlanRequests = <PlanRequest>[].obs;
  var trainerNewPlanRequests = <PlanRequest>[].obs;
  var trainerPendingPlanRequests = <PlanRequest>[].obs;
  var trainerCompletedPlanRequests = <PlanRequest>[].obs;
  var trainerRejectedPlanRequests = <PlanRequest>[].obs;

  // progress variables
  var doneFetchingRequests = false.obs;

  void getTrainerPlanRequests(String trainerId) async {
    doneFetchingRequests.value = false;
    trainerPlanRequests.clear();
    trainerNewPlanRequests.clear();
    trainerPendingPlanRequests.clear();
    trainerRejectedPlanRequests.clear();
    trainerCompletedPlanRequests.clear();
    Stream<PlanRequest> stream =
        await planRequestRepo.getTrainerPlanRequests(trainerId);
    stream.listen((PlanRequest request) {
      trainerPlanRequests.add(request);
      switch (request.reqStatus) {
        case 1:
          {
            // not rejected not accepted
            trainerNewPlanRequests.add(request);
          }
          break;
        case 2:
          {
            // plans accepted but yet to be made
            trainerPendingPlanRequests.add(request);
          }
          break;
        case 3:
          {
            trainerRejectedPlanRequests.add(request);
          }
          break;
        case 4:
          {
            trainerCompletedPlanRequests.add(request);
          }
          break;
        default:
          {
            print("request status unknow");
          }
          break;
      }
    }, onError: (e) {
      print("Plans Controller Error: $e");
    }, onDone: () {
      doneFetchingRequests.value = true;
      print("done getting requests");
    });
  }

  Future<bool> changePlanRequestStatus(
      BuildContext context, String requestId, String status) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    bool isChanged;
    await planRequestRepo.changeRequestStatus(requestId, status).then((value) {
      isChanged = value;
      GetBar snackBar = new GetBar(
        title: "Success",
        message: "Requested accepted.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: new Duration(seconds: 2),
      );
      Get.showSnackbar(snackBar).then((value) {
        Get.back();
      });
    }).onError((error, stackTrace) {
      isChanged = false;
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
    return isChanged;
  }

  Future<void> refreshPlanRequests(String trainerId) async {
    getTrainerPlanRequests(trainerId);
  }
}
