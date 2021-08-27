import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/dietPlan.dart';
import 'package:ironbox/src/repositories/dietPlan_repo.dart' as dietPlanRepo;

class DietPlanController extends GetxController {
  DietPlan dietPlan = DietPlan();
  bool isPlanCreated = false;
  String createdDietPlanId = "";

  void createDietPlan(BuildContext context, File coverImg) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    await dietPlanRepo
        .createDietPlan(dietPlan, coverImg)
        .then((DietPlan _plan) {
      if (_plan.title != null && _plan.title.isNotEmpty) {
        isPlanCreated = true;
        createdDietPlanId = _plan.id;
      }
    }).onError((error, stackTrace) {
      print("Diet Plan Controller Error: $error");
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void deleteDietPlan(String planId) async {
    dietPlanRepo.deleteDietPlan(planId);
  }
}
