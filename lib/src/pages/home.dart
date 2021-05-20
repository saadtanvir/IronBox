import 'dart:async';

import 'package:fitness_app/src/controllers/home_controller.dart';
import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/widgets/categoriesWidget.dart';
import 'package:fitness_app/src/widgets/recommendedCarousel.dart';
import 'package:fitness_app/src/widgets/upcomingChallengesCardWidget.dart';
import 'package:fitness_app/src/widgets/showMessageIconWidget.dart';
import 'package:fitness_app/src/widgets/userDetailsCardWidget.dart';
import 'package:fitness_app/src/pages/create_acc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;

class Home extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  Home({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  HomeController _con = Get.put(HomeController());

  @override
  void initState() {
    print("inside init of Home Page");
    _con.checkActivityRecognitionPermission();
    _con.checkBodySensorPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Image(
          image: AssetImage("assets/img/logo_vertical.png"),
        ),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.notes_rounded,
              color: Theme.of(context).accentColor),
          onPressed: () {
            widget.parentScaffoldKey.currentState.openDrawer();
          },
        ),
        // actions: [
        //   MessageIconWidget(),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserDetailsCardWidget(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: UpcomingChallengesWidget(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Constants.appCategories != null &&
                      Constants.appCategories.isNotEmpty
                  ? CategoriesWidget()
                  : CircularProgressIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: ListTile(
                title: Text(
                  Constants.capitalRecommended,
                  style: Helper.of(context).textStyle(
                    color: Theme.of(context).primaryColor,
                    font: FontWeight.bold,
                  ),
                ),
              ),
            ),
            RecommendedCaroousel(),
          ],
        ),
      ),
    );
  }

  // to maintain the state of page in
  // bottom navigation
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
