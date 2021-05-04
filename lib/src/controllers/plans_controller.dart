import 'package:fitness_app/src/models/plan.dart';
import 'package:fitness_app/src/repositories/plan_repo.dart' as planRepo;
import 'package:fitness_app/src/services/stripe_payments.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PlansController extends GetxController {
  StripePaymentServices _stripePaymentServices = StripePaymentServices();
  List<Plan> plans = List<Plan>().obs;
  PlansController() {
    print("constructor of plans controller");
  }

  void getPlansByCategory(String category) async {
    plans.clear();
    final Stream<Plan> stream = await planRepo.getPlansByCategory(category);

    stream.listen(
      (Plan _plan) {
        plans.add(_plan);
      },
      onError: (e) {
        print("Plans Controller Error: $e");
      },
      onDone: () {
        print("done fetching plans");
      },
    );
  }

  void getUserPlansByCategory(String category, String userId) async {
    plans.clear();
    final Stream<Plan> stream =
        await planRepo.getUserPlansByCategory(category, userId);

    stream.listen(
      (Plan _plan) {
        plans.add(_plan);
      },
      onError: (e) {
        print("Plans Controller Error: $e");
      },
      onDone: () {
        print("done fetching plans");
      },
    );
  }

  void buyPlan(
      {BuildContext context, String planId, String category, String userId}) {
    // check if plan already exist
    // if not, initialize payments
    // if payment successful
    // call add plan api
    _stripePaymentServices.initializeStripePayments();
    _stripePaymentServices
        .payWithNewCard("100", "usd")
        .then((confirmed) {
          if (confirmed) {
            // show snackbar
          } else {
            // show snackbar
          }
        })
        .catchError((e) {})
        .whenComplete(() {});
  }
}
