import '../models/reviews.dart';
import '../models/subscriptions.dart';
import '../widgets/T_trainerProfileDetails.dart';
import '../widgets/subscribedTrainerProfile.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;
import '../services/firebase_methods.dart';
import '../pages/create_acc.dart';

class UserController extends GetxController {
  User user;
  Subscription subscription = new Subscription();
  List<Review> reviews = List<Review>().obs;
  List<User> trainers = List<User>().obs;
  List<Subscription> subscriptions = List<Subscription>().obs;
  FirebaseMethods firebaseMethods = FirebaseMethods();
  OverlayEntry loader;
  var doneFetchingTrainers = false.obs;
  var doneFetchingSubscriptions = false.obs;
  var doneFetchingReviews = false.obs;
  bool isTrainerSubscribed;

  UserController();

  @override
  void onInit() {
    this.user = new User();
    super.onInit();
  }

  void registerUser(BuildContext context) {
    print("in register function of user controller");
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    userRepo.register(user).then((value) {
      if (value.id != null) {
        print(value.id);
        // add username and url to firebase collection user
        // under doc id = user id
        firebaseMethods.addUserToFirebase(
            uid: value.id, username: value.userName, imgURL: value.avatar);

        Get.snackbar(
          Constants.success,
          Constants.user_registered_successfully_you_can_login_now,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Future.delayed(new Duration(seconds: 2)).then((value) {
          userRepo.currentUser.value = new User();
          Get.offAll(CreateAccount());
        });
      } else {
        Get.snackbar(
          Constants.failed,
          Constants.user_already_exist,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }).catchError((e) {
      print("registration failed");
      Get.snackbar(
        Constants.failed,
        Constants.check_internet_connection,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }).whenComplete(() {
      print("registration process completed");
      Helper.hideLoader(loader);
    });
  }

  void registerUserWithImage(BuildContext context) {
    print("in register with image function of user controller");
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    userRepo.registerUserWithImage(user).then((value) {
      print(value.id);
      print(value.email);
      if ((value.id != null && value.id.isNotEmpty) &&
          (value.email != null && value.email.isNotEmpty)) {
        // add username and url to firebase collection user
        // under doc id = user id
        print(value.id);
        firebaseMethods.addUserToFirebase(
            uid: value.id, username: value.userName, imgURL: value.avatar);

        Get.snackbar(
          Constants.success,
          Constants.user_registered_successfully_you_can_login_now,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Future.delayed(new Duration(seconds: 1)).then((value) {
          userRepo.currentUser.value = new User();
          Get.offAll(CreateAccount());
        });
      } else {
        Get.snackbar(
          Constants.failed,
          Constants.something_went_wrong,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }).catchError((e) {
      print("registration failed");
      print(e);
      Get.snackbar(
        Constants.failed,
        Constants.something_went_wrong,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }).whenComplete(() {
      print("registration process completed");
      Helper.hideLoader(loader);
    });
  }

  void login(BuildContext context) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    userRepo.login(user).then((value) {
      if (value.userToken != null) {
        // check role
        // redirect accordingly
        if (value.isTrainee == "1") {
          Get.offAllNamed('/BottomNavBarPage');
        } else if (value.isTrainer == "1") {
          if (value.accountStatus == 1) {
            Get.offAllNamed('/TrainerBtmNavBar');
          } else {
            print("Trainer not approved yet");
            Get.offAllNamed('/TrainerUnApprovedAccount');
          }
        }
      } else {
        Get.snackbar(
          Constants.login_failed,
          Constants.user_not_found,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      // print(value.id);
    }).catchError((e) {
      print("error caught");
      print(e);
      Get.snackbar(
        Constants.login_failed,
        Constants.check_internet_connection,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }).whenComplete(() {
      print("login process completed");
      Helper.hideLoader(loader);
    });
  }

  void updateCurrentUser(BuildContext context, User currentUser) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    print("current user acc status: ${currentUser.accountStatus}");
    userRepo.updateCurrentUser(currentUser).then((value) {
      print(value.role);
      print(value.id);
      if (value.id != null) {
        if (value.role.capitalizeFirst == Constants.joinAsA[0]) {
          Get.offAllNamed('/BottomNavBarPage');
        } else if (value.role.capitalizeFirst == Constants.joinAsA[1]) {
          print("its a trainer");
          if (value.accountStatus == 1) {
            Get.offAllNamed('/TrainerBtmNavBar');
          } else {
            print("Trainer not approved yet");
            Get.offAllNamed('/TrainerUnApprovedAccount');
          }
        }
      }
    }).catchError((e) {
      print("error caught");
      print(e);
      Get.snackbar(
        Constants.registration_failed,
        Constants.check_internet_connection,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }).whenComplete(() {
      print("registration process completed");
      Helper.hideLoader(loader);
    });
  }

  Future<User> getUpdatedCurrentUser(String uid) async {
    // if user updated by admin
    // get the latest characterstics
    return await userRepo.getUpdatedCurrentUser(uid);
  }

  Future<void> fetchAllTrainers() async {
    doneFetchingTrainers.value = false;
    trainers.clear();
    final Stream<User> stream = await userRepo.fetchAllTrainers();
    stream.listen((User _user) {
      if (_user.id != userRepo.currentUser.value.id) {
        trainers.add(_user);
      }
    }, onError: (e) {
      print(e);
    }, onDone: () {
      print("done fetching trainers");
      doneFetchingTrainers.value = true;
    });
  }

  void fetchUserSubscriptions(String uid) async {
    doneFetchingSubscriptions.value = false;
    subscriptions.clear();
    final Stream<Subscription> stream =
        await userRepo.fetchUserSubscribedTrainers(uid);
    stream.listen((Subscription _userSub) {
      subscriptions.add(_userSub);
    }, onError: (e) {
      print(e);
    }, onDone: () {
      print("done fetching trainers");
      doneFetchingSubscriptions.value = true;
    });
  }

  void getTrainerReviews(String id) async {
    doneFetchingReviews.value = false;
    reviews.clear();
    final Stream<Review> stream = await userRepo.getTrainerReviews(id);
    stream.listen((Review _review) {
      reviews.add(_review);
    }, onError: (e) {
      print(e);
    }, onDone: () {
      print("done fetching reviews");
      doneFetchingReviews.value = true;
    });
  }

  void subscribeTrainer(BuildContext context) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    await userRepo.subscribeTrainer(subscription).then((value) {
      if (value) {
        Get.snackbar(
          "Success",
          "Trainer Subscribed Successfully",
          backgroundColor: Colors.green,
          colorText: Theme.of(context).scaffoldBackgroundColor,
        );

        Future.delayed(new Duration(seconds: 1)).then((value) {
          Get.offAllNamed('/BottomNavBarPage');
        });
      } else {
        Get.snackbar("Failed!", "Trainer Subscription Failed.",
            backgroundColor: Theme.of(context).primaryColor);
      }
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  Future<bool> checkIsTrainerSubscribed(BuildContext context,
      {@required String uid,
      @required String trainerId,
      @required User trainer}) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    userRepo
        .isTrainerSubscribed(uid: uid, trainerId: trainerId)
        .then((Subscription _sub) {
      print(_sub.trainers.email.isEmail);
      if (_sub.trainers.email.isEmail) {
        print("redirecting to subscribed profile");
        Get.to(SubscribedTrainerProfile(_sub),
            transition: Transition.rightToLeft);
        // Helper.hideLoader(loader);
      } else {
        Get.to(
            TrainerProfileDetails(
              trainer: trainer,
            ),
            transition: Transition.rightToLeft);
        // Helper.hideLoader(loader);
      }
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  Future<bool> postTrainerReview(
      {@required BuildContext context,
      @required String trainerId,
      @required String userId,
      @required String review}) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    return await userRepo
        .reviewTrainer(trainerId: trainerId, userId: userId, review: review)
        .whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  Future<bool> rateTrainer(
      BuildContext context, int rating, String trainerId) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    return await userRepo.rateTrainer(rating, trainerId).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  Future<void> unsubscribeTrainer(
      BuildContext context, Subscription subscription) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    firebaseMethods
        .unsubscribeTrainer(
            userRepo.currentUser.value.id, subscription.trainers.id)
        .then((value) {
      print("value from firebase deletion");
      print(value);
      userRepo.unsubscribeTrainer(subscription.id).then((value) {
        if (value) {
          Get.snackbar(
            "Success!",
            "Trainer Unsubscribed.",
            colorText: Theme.of(context).scaffoldBackgroundColor,
            backgroundColor: Colors.green,
          );
          Future.delayed(new Duration(seconds: 1)).then((value) {
            Get.offAllNamed('/BottomNavBarPage');
          });
        } else {
          Get.snackbar(
            "Failed!",
            "Try again.",
            colorText: Theme.of(context).scaffoldBackgroundColor,
            backgroundColor: Theme.of(context).primaryColor,
          );
        }
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    });
  }

  Future<void> removeCurrentUser(BuildContext context) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    userRepo.removeCurrentUser().then((value) {
      Get.offAll(CreateAccount());
    }).catchError((e) {
      print("User Controller Error: $e");
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  Future<void> refreshUserSubscriptions() async {
    await fetchUserSubscriptions(userRepo.currentUser.value.id);
  }
}
