import 'dart:io';
import 'package:ironbox/src/models/planRequest.dart';
import '../widgets/dialogs/successDialog.dart';
import '../helpers/helper.dart';
import '../models/category.dart';
import '../models/plan.dart';
import '../models/reviews.dart';
import '../models/userWorkoutPlan.dart';
import '../models/workoutPlan.dart';
import '../models/workoutPlanDetails.dart';
import '../models/workoutPlanExercise.dart';
import '../models/workoutPlanGame.dart';
import '../pages/T_btmNavBar.dart';
import '../pages/userWorkoutPlanDetails.dart';
import '../pages/workoutPlanDetails.dart';
import '../repositories/plan_repo.dart' as planRepo;
import '../widgets/workoutPlansWidget.dart/addGames.dart';
import '../widgets/workoutPlansWidget.dart/selectWeek.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/category_repo.dart' as categoryRepo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlansController extends GetxController {
  // class objects
  // StripePaymentServices _stripePaymentServices = StripePaymentServices();
  Plan plan = new Plan();
  WorkoutPlan workoutPlan = new WorkoutPlan();
  WorkoutPlanDetails workoutPlanDetails = new WorkoutPlanDetails();
  WorkoutPlanGame workoutPlanGame = new WorkoutPlanGame();
  WorkoutPlanExercise workoutPlanExercise = new WorkoutPlanExercise();

  // lists
  List<Plan> plans = List<Plan>().obs;
  List<UserWorkoutPlan> userWorkoutPlans = List<UserWorkoutPlan>().obs;
  List<WorkoutPlan> workoutPlans = List<WorkoutPlan>().obs;
  var trainerWorkoutPlansList = List<WorkoutPlan>().obs;
  var workoutPlanDetailsList = List<WorkoutPlanDetails>().obs;
  var workoutPlanGamesList = List<WorkoutPlanGame>().obs;
  var workoutPlanExercisesList = List<WorkoutPlanExercise>().obs;
  var workoutPlanReviews = List<Review>().obs;
  var categories = List<Category>().obs;

  // variables
  OverlayEntry loader;
  var createdWorkoutPlanId = "".obs;

  // progress variables
  var doneFetchingPlans = false.obs;
  var doneFetchingUserWorkoutPlans = false.obs;
  var doneFetchingWorkoutPlanDetails = false.obs;
  var doneFetchingWorkoutPlanGames = false.obs;
  var doneAddingGame = false.obs;
  var doneFetchingGameExercises = false.obs;
  var doneAddingExercise = false.obs;
  var doneFetchingReviews = false.obs;

  //////////////////////////////////////////////////////////////////////////////
  PlansController() {
    print("constructor of plans controller");
  }

  Future<void> listenForCategories() async {
    print("fetching categories from plans controller");
    categories.clear();
    Constants.appCategories.clear();
    Stream<Category> stream = await categoryRepo.getAppCategories();

    stream.listen((Category _category) {
      print(_category.backgroundImgUrl);
      categories.add(_category);
      Constants.appCategories.add(_category);
    }, onError: (e) {
      print("Error thrown while getting categories: $e");
    }, onDone: () {
      print("Done fetching categories");
    });
  }

  Future<void> getSubCategories() async {
    Constants.subCategories.clear();
    Stream<Category> stream = await categoryRepo.getSubCategories();

    stream.listen((Category _category) {
      Constants.subCategories.add(_category);
    }).onError((e) {
      print("Error getting subcategories: $e");
    });
  }

  Future<void> getChildCategories() async {
    Constants.childCategories.clear();
    Stream<Category> stream = await categoryRepo.getChildCategories();

    stream.listen((Category _category) {
      Constants.childCategories.add(_category);
    }).onError((e) {
      print("Error getting child categories: $e");
    });
  }

  void getAllWorkoutPlans({int skip, int take}) async {
    doneFetchingPlans.value = false;
    workoutPlans.clear();
    final Stream<WorkoutPlan> stream = await planRepo.getAllWorkoutPlans();

    stream.listen(
      (WorkoutPlan _plan) {
        workoutPlans.add(_plan);
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

  void getAllUserWorkoutPlans(String uid) async {
    doneFetchingUserWorkoutPlans.value = false;
    userWorkoutPlans.clear();
    final Stream<UserWorkoutPlan> stream =
        await planRepo.getAllUserWorkoutPlans(uid);

    stream.listen(
      (UserWorkoutPlan _plan) {
        userWorkoutPlans.add(_plan);
      },
      onError: (e) {
        print("Plans Controller Error: $e");
      },
      onDone: () {
        print("done fetching user workout plans");
        doneFetchingUserWorkoutPlans.value = true;
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

  Future<void> checkIsPlanSubscribed(
      {@required BuildContext context,
      @required WorkoutPlan workoutPlan,
      @required String uid,
      @required String pid}) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    planRepo.checkIsPlanSubscribed(uid, pid).then((UserWorkoutPlan _userPlan) {
      print(_userPlan.title.isEmpty);
      if (_userPlan.title.isNotEmpty) {
        // go to details plan page
        Get.to(
          ShowUserWorkoutPlanDetails(_userPlan),
          transition: Transition.rightToLeft,
        );
      } else {
        // show plan details for subscription
        Get.to(
          ShowWOPDetails(workoutPlan),
          transition: Transition.rightToLeft,
        );
      }
    }).onError((error, stackTrace) {
      print("Plans controller error:");
      print(error.toString());
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void getTrainerWorkoutPlans(String trainerId) async {
    doneFetchingPlans.value = false;
    trainerWorkoutPlansList.clear();
    final Stream<WorkoutPlan> stream =
        await planRepo.getTrainerWorkoutPlans(trainerId);
    stream.listen(
      (WorkoutPlan _plan) {
        trainerWorkoutPlansList.add(_plan);
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

  void createWorkoutPlan(
    BuildContext context,
    File image,
  ) async {
    print(image.path);
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    planRepo
        .createWorkoutPlan(workoutPlan, image: image)
        .then((WorkoutPlan _workoutPlan) {
      if (_workoutPlan.id != null && _workoutPlan.description.isNotEmpty) {
        // GetBar snackBar = new GetBar(
        //   title: "Success",
        //   message: "Plan created successfully.",
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.green,
        //   duration: new Duration(seconds: 2),
        // );
        print(_workoutPlan.durationInWeeks);
        createdWorkoutPlanId.value = _workoutPlan.id;
        Get.to(
          SelectWeek(_workoutPlan.id, _workoutPlan.durationInWeeks),
          transition: Transition.rightToLeft,
        );
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

  Future<void> updateWorkoutPlan(
    BuildContext context,
    File image,
  ) async {
    print(image.path);
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    planRepo
        .updateWorkoutPlan(workoutPlan, image)
        .then((WorkoutPlan _workoutPlan) {
      if (_workoutPlan.id != null && _workoutPlan.description.isNotEmpty) {
        // GetBar snackBar = new GetBar(
        //   title: "Success",
        //   message: "Plan created successfully.",
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.green,
        //   duration: new Duration(seconds: 2),
        // );
        print(_workoutPlan.durationInWeeks);
        createdWorkoutPlanId.value = _workoutPlan.id;
        Get.to(
          SelectWeek(_workoutPlan.id, _workoutPlan.durationInWeeks),
          transition: Transition.rightToLeft,
        );
      } else {
        Get.snackbar(
          "Failed !",
          "Try making a new plan or check your internet connection.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
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

  void deleteWorkoutPlan(String pid) {
    planRepo
        .deleteWorkoutPlan(pid)
        .then((value) {
          print("plan deleted");
        })
        .onError((error, stackTrace) {})
        .whenComplete(() {});
  }

  void createWorkoutPlanDetails(BuildContext context) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    planRepo
        .createWorkoutPlanDetails(workoutPlanDetails)
        .then((WorkoutPlanDetails _workoutPlanDetails) {
      if (_workoutPlanDetails.id != null &&
          _workoutPlanDetails.dayTitle.isNotEmpty) {
        print(_workoutPlanDetails.dayTitle);
        Get.to(
          AddWorkoutPlanGame(_workoutPlanDetails.id),
          transition: Transition.rightToLeft,
        );
      } else {
        Get.snackbar(
          "${Constants.failed}",
          "${Constants.check_internet_connection}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }).catchError((e) {
      Get.snackbar(
        "${Constants.failed}",
        "${Constants.check_internet_connection}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void updateWorkoutPlanDetails(BuildContext context) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    planRepo
        .updateWorkoutPlanDetails(workoutPlanDetails)
        .then((WorkoutPlanDetails _workoutPlanDetails) {
      if (_workoutPlanDetails.id != null &&
          _workoutPlanDetails.dayTitle.isNotEmpty) {
        print(_workoutPlanDetails.dayTitle);
        Get.to(
          AddWorkoutPlanGame(_workoutPlanDetails.id),
          transition: Transition.rightToLeft,
        );
      } else {
        Get.snackbar(
          "${Constants.failed}",
          "${Constants.check_internet_connection}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }).catchError((e) {
      Get.snackbar(
        "${Constants.failed}",
        "${Constants.check_internet_connection}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void getWorkoutPlanDetails(
      {@required String planId,
      @required int weekNum,
      @required int dayNum}) async {
    doneFetchingWorkoutPlanDetails.value = false;
    workoutPlanDetails = new WorkoutPlanDetails();
    planRepo
        .getWorkoutPlanDetails(planId: planId, weekNum: weekNum, dayNum: dayNum)
        .then((WorkoutPlanDetails _workoutPlanDetails) {
      print(_workoutPlanDetails);
      if (_workoutPlanDetails.id != null &&
          _workoutPlanDetails.dayTitle.isNotEmpty) {
        workoutPlanDetails = _workoutPlanDetails;
      }
    }).onError((error, stackTrace) {
      print(error);
      // snackbar
      // check internet connection
    }).whenComplete(() {
      // Helper.hideLoader(loader);
      doneFetchingWorkoutPlanDetails.value = true;
    });
  }

  void createWorkoutPlanGame(BuildContext context) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    doneAddingGame.value = false;
    planRepo
        .createWorkoutPlanGame(workoutPlanGame)
        .then((WorkoutPlanGame _game) {
      print(_game.name);
      if (_game.id != null && _game.name.isNotEmpty) {
        workoutPlanGamesList.add(_game);
        Get.snackbar(
          "Success",
          "Game added successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: new Duration(seconds: 1),
        );
      } else {
        Get.snackbar(
          "Failed!",
          "Check your connection and try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: new Duration(seconds: 1),
        );
      }
    }).onError((e, stackTrace) {
      print("Error creating game: $e");
    }).whenComplete(() {
      Helper.hideLoader(loader);
      doneAddingGame.value = true;
    });
  }

  void getWorkoutPlanGames(String detailsId) async {
    workoutPlanGamesList.clear();
    doneFetchingWorkoutPlanGames.value = false;

    final Stream<WorkoutPlanGame> stream =
        await planRepo.getWorkoutPlanGames(detailsId);
    stream.listen((WorkoutPlanGame _game) {
      if (_game.id != null && _game.name.isNotEmpty) {
        workoutPlanGamesList.add(_game);
      }
    }, onError: (e) {
      print("Error getting WP games: $e");
    }, onDone: () {
      doneFetchingWorkoutPlanGames.value = true;
    });
  }

  void createWorkoutPlanExercise(BuildContext context) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    doneAddingExercise.value = false;
    planRepo
        .createWorkoutPlanExercise(workoutPlanExercise)
        .then((WorkoutPlanExercise _exercise) {
      if (_exercise.id != null && _exercise.name.isNotEmpty) {
        workoutPlanExercisesList.add(_exercise);
        Get.snackbar(
          "Success",
          "Exercise added successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: new Duration(seconds: 1),
        );
      }
    }).onError((e, stackTrace) {
      print("Error creating exercise: $e");
    }).whenComplete(() {
      Helper.hideLoader(loader);
      doneAddingExercise.value = true;
    });
  }

  void getWorkoutPlanGameExercises(String gameId) async {
    workoutPlanExercisesList.clear();
    doneFetchingGameExercises.value = false;

    final Stream<WorkoutPlanExercise> stream =
        await planRepo.getWorkoutPlanGameExercises(gameId);
    stream.listen((WorkoutPlanExercise _exercise) {
      if (_exercise.id != null && _exercise.name.isNotEmpty) {
        workoutPlanExercisesList.add(_exercise);
      }
    }, onError: (e) {
      print("Error getting WP games exercises: $e");
    }, onDone: () {
      doneFetchingGameExercises.value = true;
    });
  }

  void postWOPRating(BuildContext context, String planId, String rating) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    planRepo.postWOPRating(planId, rating).then((value) {
      if (value) {
        Get.snackbar(
          "Success",
          "Rated Successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          Constants.failed,
          Constants.check_internet_connection,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    }).onError((error, stackTrace) {
      Get.snackbar(
        Constants.failed,
        Constants.check_internet_connection,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void postWOPReview(BuildContext context,
      {@required String planId,
      @required String review,
      @required String rating,
      @required String userId}) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    planRepo
        .postWOPReview(
            planId: planId, review: review, rating: rating, userId: userId)
        .then((value) {
      if (value) {
        Get.snackbar(
          "Success",
          "Posted Successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          Constants.failed,
          Constants.check_internet_connection,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    }).onError((error, stackTrace) {
      Get.snackbar(
        Constants.failed,
        Constants.check_internet_connection,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void getWOPReviews(String planId) async {
    doneFetchingReviews.value = false;
    workoutPlanReviews.clear();
    final Stream<Review> stream = await planRepo.getWOPReviews(planId);
    stream.listen((Review _review) {
      workoutPlanReviews.add(_review);
    }, onError: (e) {
      print(e);
    }, onDone: () {
      print("done fetching reviews");
      doneFetchingReviews.value = true;
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

  void subscribeWorkoutPlan(
      BuildContext context, String pid, String uid) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    planRepo.subscribeWorkoutPlan(pid, uid).then((UserWorkoutPlan _userPlan) {
      print(_userPlan.id);
      if (_userPlan.id.isNotEmpty) {
        GetBar snackBar = new GetBar(
          title: "Success",
          message: "You have successfully bought ${_userPlan.title}.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: new Duration(seconds: 2),
        );

        Get.showSnackbar(snackBar).then((value) {
          Get.offAllNamed('/BottomNavBarPage');
        });
      } else {
        Get.snackbar(
          "Failed!",
          "Check your connection and try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: new Duration(seconds: 1),
        );
      }
    }).onError((error, stackTrace) {
      print("plans controller error: $error");
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void addUserWOPWeekToLogs(
      {@required BuildContext context,
      @required String planId,
      @required int weekNum,
      @required String categoryId,
      @required String createdBy,
      @required String userId}) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    await planRepo
        .addUserWOPWeekToLogs(
            planId: planId,
            weekNum: weekNum,
            categoryId: categoryId,
            createdBy: createdBy,
            userId: userId)
        .then((value) {
      if (value) {
        Get.dialog(SuccessDialog());
      }
    }).onError((error, stackTrace) {
      Get.snackbar(
        "Failed!",
        "Check your connection and try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: new Duration(seconds: 1),
      );
      print("Plans Controller Error: $error");
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  // void buyPlan(
  //     {BuildContext context, String planId, String category, String userId}) {
  //   // check if plan already exist
  //   // if not, initialize payments
  //   // if payment successful
  //   // call add plan api
  //   _stripePaymentServices.initializeStripePayments();
  //   _stripePaymentServices
  //       .payWithNewCard("100", "usd")
  //       .then((confirmed) {
  //         if (confirmed) {
  //           // show snackbar
  //         } else {
  //           // show snackbar
  //         }
  //       })
  //       .catchError((e) {})
  //       .whenComplete(() {});
  // }
}
