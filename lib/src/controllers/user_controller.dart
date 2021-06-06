import 'package:ironbox/src/models/subscriptions.dart';

import '../helpers/helper.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;
import '../services/firebase_methods.dart';
import '../pages/create_acc.dart';

class UserController extends GetxController {
  User user = new User();
  Subscription subscription = new Subscription();
  List<User> trainers = List<User>().obs;
  FirebaseMethods firebaseMethods = FirebaseMethods();
  OverlayEntry loader;
  var doneFetchingTrainers = false.obs;

  UserController();

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

  void updateUser(BuildContext context, User currentUser) async {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    print(currentUser.accountStatus);
    userRepo.updateUser(currentUser).then((value) {
      print(value.role);
      print(value.id);
      if (value.id != null) {
        if (value.role == Constants.joinAsA[0]) {
          Get.offAllNamed('/BottomNavBarPage');
        } else if (value.role == Constants.joinAsA[1]) {
          print("its a trainer");
          if (userRepo.currentUser.value.accountStatus == 1) {
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

  void fetchAllTrainers() async {
    doneFetchingTrainers.value = false;
    trainers.clear();
    final Stream<User> stream = await userRepo.fetchAllTrainers();
    stream.listen((User _user) {
      // print(_user.isTrainer);
      // print(_user.accountStatus);
      // print(_user.id);
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

  void subscribeTrainer() async {
    bool isSubscribed = await userRepo.subscribeTrainer(subscription);
    print(isSubscribed);
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
}
