import 'package:ironbox/src/controllers/T_homeController.dart';
import 'package:ironbox/src/pages/messages.dart';
import 'package:ironbox/src/widgets/conversationsListWidget.dart';
import 'package:ironbox/src/widgets/showMessageIconWidget.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerHomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  TrainerHomePage({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _TrainerHomePageState createState() => _TrainerHomePageState();
}

class _TrainerHomePageState extends State<TrainerHomePage> {
  // show clients list on this page
  TrainerHomeController _con = Get.put(TrainerHomeController());
  @override
  void initState() {
    // if (userRepo.currentUser.value.userToken != null) {
    //   _con.getClientsList(userRepo.currentUser.value.id);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Messages(
      parentScaffoldKey: widget.parentScaffoldKey,
    );
  }
}
