import 'package:ironbox/src/controllers/user_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/widgets/T_miniRegistration.dart';
import 'package:ironbox/src/widgets/miniRegistrationWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';
import 'package:ironbox/src/widgets/userProfile.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:ironbox/src/repositories/user_repo.dart' as userRepo;

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  UserController _con = Get.put(UserController());
  var trainerMode = userRepo.currentUser.value.role == Constants.joinAsA[1]
      ? true.obs
      : false.obs;

  void _switchUserRole(bool value) {
    if (value) {
      if (userRepo.currentUser.value.experience != null &&
          userRepo.currentUser.value.experience.isNotEmpty) {
        // update user role in db
        // get new user obj
        // set new user in sp
        // redirect
        userRepo.currentUser.value.role = Constants.joinAsA[1];
        print(userRepo.currentUser.value.toMap());
        _con.updateUser(context, userRepo.currentUser.value);
      } else {
        // go to mini registration page
        // update user fields and role in db
        // get new user obj
        // set new user in sp
        // redirect
        Get.to(TrainerRegistrationForm(), fullscreenDialog: true);
      }
    } else if (!value) {
      if (userRepo.currentUser.value.injury != null &&
          userRepo.currentUser.value.injury.isNotEmpty) {
        // update user role in db
        // get new user obj
        // set new user in sp
        // redirect
        userRepo.currentUser.value.role = Constants.joinAsA[0];
        print(userRepo.currentUser.value.toMap());
        _con.updateUser(context, userRepo.currentUser.value);
      } else {
        // go to mini registration page
        // update user fields and role in db
        // get new user obj
        // set new user in sp
        // redirect
        Get.to(TraineeRegistrationForm(), fullscreenDialog: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: Helper.of(context).getScreenHeight() * 0.25,
            width: Helper.of(context).getScreenWidth(),
            child: Card(
              margin: EdgeInsets.zero,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserCircularAvatar(70.0, 70.0,
                      "${userRepo.currentUser.value.avatar}", BoxFit.cover),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "${userRepo.currentUser.value.name}",
                    style: Helper.of(context)
                        .textStyle(size: 17.0, font: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListTile(
            onTap: () {
              // go on user profile page
              Get.to(UserProfilePage(
                  userRepo.currentUser.value,
                  userRepo.currentUser.value.role == Constants.joinAsA[1]
                      ? true
                      : false));
            },
            leading: Icon(
              Icons.person,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Profile",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Divider(
            thickness: 2.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    Constants.change_user_mode,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Obx(() {
                  return CupertinoSwitch(
                    onChanged: (value) {
                      _switchUserRole(value);
                    },
                    value: trainerMode.value,
                    activeColor: Theme.of(context).primaryColor,
                  );
                }),
              )
            ],
          ),
          ListTile(
            onTap: () {
              _con.removeCurrentUser(context);
            },
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Logout",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
