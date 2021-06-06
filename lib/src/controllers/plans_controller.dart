import 'dart:io';

import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/plan.dart';
import 'package:ironbox/src/pages/T_btmNavBar.dart';
import 'package:ironbox/src/repositories/plan_repo.dart' as planRepo;
import 'package:ironbox/src/services/stripe_payments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlansController extends GetxController {
  StripePaymentServices _stripePaymentServices = StripePaymentServices();
  Plan plan = new Plan();
  List<Plan> plans = List<Plan>().obs;
  var doneFetchingPlans = false.obs;
  OverlayEntry loader;
  PlansController() {
    print("constructor of plans controller");
  }

  void getPlansByCategory(String category) async {
    doneFetchingPlans.value = false;
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
        doneFetchingPlans.value = true;
      },
    );
  }

  void getUserPlansByCategory(String category, String userId) async {
    doneFetchingPlans.value = false;
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
        doneFetchingPlans.value = true;
      },
    );
  }

  void getTrainerPlans(String trainerId) async {
    doneFetchingPlans.value = false;
    plans.clear();
    final Stream<Plan> stream = await planRepo.getTrainerPlans(trainerId);
    stream.listen(
      (Plan _plan) {
        plans.add(_plan);
      },
      onError: (e) {
        print(e);
      },
      onDone: () {
        print("done fetching plans");
        doneFetchingPlans.value = true;
      },
    );
  }

  void searchPlan(String searchString, String category) async {
    doneFetchingPlans.value = false;
    plans.clear();
    final Stream<Plan> stream =
        await planRepo.searchPlans(searchString, category);
    stream.listen((Plan _plan) {
      plans.add(_plan);
    }, onError: (e) {
      print(e);
    }, onDone: () {
      print("done fetching plans");
      doneFetchingPlans.value = true;
    });
  }

  void createPlan(BuildContext context, File image) async {
    print(image.path);
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    planRepo.createPlan(plan, image: image).then((Plan _p) {
      if (_p.id != null) {
        GetBar snackBar = new GetBar(
          title: "Success",
          message: "Plan created successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: new Duration(seconds: 2),
        );

        Get.showSnackbar(snackBar).then((value) {
          print(value);
          Get.back();
        });
      } else {
        Get.snackbar(
          "Failed !",
          "Try making a new plan or check your internet connection.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      // Get.back();
    }).catchError((e) {
      Get.snackbar(
        "Failed !",
        "Check your internet connect",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void editPlan(BuildContext context, Plan plan) {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    planRepo.editPlan(plan).then((value) {
      if (value) {
        GetBar snackBar = new GetBar(
          title: "Success",
          message: "Plan edited successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: new Duration(seconds: 2),
        );

        Get.showSnackbar(snackBar).then((value) {
          Get.offAll(TrainerBottomNavBar(
            currentTab: 0,
          ));
        });
      }
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
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
