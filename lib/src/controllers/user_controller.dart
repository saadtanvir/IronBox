import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;
import '../services/firebase_methods.dart';
import '../pages/create_acc.dart';

class UserController extends GetxController {
  User user = new User();
  FirebaseMethods firebaseMethods = FirebaseMethods();
  OverlayEntry loader;

  UserController() {}

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
            uid: value.id,
            username: value.userName,
            imgURL:
                "https://th.bing.com/th/id/Rcbe9c6caa4f9030112f28aa9df8e33e2?rik=pCI5m%2fgWp8%2fWWw&riu=http%3a%2f%2fwww.lensmen.ie%2fwp-content%2fuploads%2f2015%2f02%2fProfile-Portrait-Photographer-in-Dublin-Ireland..jpg&ehk=Za7WF72x0pY8NyUrVRiYMesP9zQuTivFSKMmlY1CkUg%3d&risl=&pid=ImgRaw");

        Get.snackbar(
          "Success",
          "User registered successfully. You can login now.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Future.delayed(new Duration(seconds: 2)).then((value) {
          Get.offAll(CreateAccount());
        });
      } else {
        Get.snackbar(
          "Failed !",
          "User already exist",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }).catchError((e) {
      print("registration failed");
      Get.snackbar(
        "Failed !",
        "Check your internet connection",
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
      if (value.id != null) {
        // add username and url to firebase collection user
        // under doc id = user id
        firebaseMethods.addUserToFirebase(
            uid: value.id,
            username: value.userName,
            imgURL:
                "https://th.bing.com/th/id/Rcbe9c6caa4f9030112f28aa9df8e33e2?rik=pCI5m%2fgWp8%2fWWw&riu=http%3a%2f%2fwww.lensmen.ie%2fwp-content%2fuploads%2f2015%2f02%2fProfile-Portrait-Photographer-in-Dublin-Ireland..jpg&ehk=Za7WF72x0pY8NyUrVRiYMesP9zQuTivFSKMmlY1CkUg%3d&risl=&pid=ImgRaw");

        Get.snackbar(
          "Success",
          "User registered successfully. You can login now.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Future.delayed(new Duration(seconds: 2)).then((value) {
          Get.offAll(CreateAccount());
        });
      } else {
        Get.snackbar(
          "Failed !",
          "User already exist",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }).catchError((e) {
      print("registration failed");
      print(e);
      Get.snackbar(
        "Failed !",
        "Check your internet connection",
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
        if (value.role == Constants.joinAsA[0]) {
          Get.offAllNamed('/BottomNavBarPage');
        } else if (value.role == Constants.joinAsA[1]) {
          if (value.accountStatus == 1) {
            Get.offAllNamed('/TrainerBtmNavBar');
          } else {
            print("Trainer not approved yet");
            Get.offAllNamed('/TrainerUnApprovedAccount');
          }
        }
      } else {
        Get.snackbar(
          "Login Failed !",
          "User not found",
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
        "Login Failed !",
        "Check your internet connection",
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
        "Registration Failed!",
        "Check your internet connection",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }).whenComplete(() {
      print("registration process completed");
      Helper.hideLoader(loader);
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
}
