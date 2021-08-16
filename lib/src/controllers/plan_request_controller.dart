import 'package:ironbox/src/models/planRequest.dart';
import '../repositories/plan_repo.dart' as planRepo;
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

    Stream<PlanRequest> stream =
        await planRepo.getTrainerPlanRequests(trainerId);
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
}
