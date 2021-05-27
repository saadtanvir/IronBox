import 'dart:async';

import 'package:ironbox/src/controllers/home_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/widgets/categoriesWidget.dart';
import 'package:ironbox/src/widgets/recommendedCarousel.dart';
import 'package:ironbox/src/widgets/upcomingChallengesCardWidget.dart';
import 'package:ironbox/src/widgets/showMessageIconWidget.dart';
import 'package:ironbox/src/widgets/userDetailsCardWidget.dart';
import 'package:ironbox/src/pages/create_acc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  DateFormat _dateFormatter;
  String currentDate;
  String dateFormat = "dd-MM-yyyy";

  @override
  void initState() {
    print("inside init of Home Page");
    _con.checkActivityRecognitionPermission();
    _con.checkBodySensorPermission();
    _dateFormatter = DateFormat(dateFormat);
    currentDate = _dateFormatter.format(DateTime.now());
    if (userRepo.currentUser.value.userToken != null &&
        userRepo.currentUser.value.userToken.isNotEmpty) {
      _con.getUpComingChallenges(userRepo.currentUser.value.id, currentDate);
    }
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
              child: Obx(() {
                return _con.upComingChallenges.isEmpty &&
                        !_con.doneFetchingChallenges.value
                    ? CircularProgressIndicator()
                    : _con.upComingChallenges.isEmpty &&
                            _con.doneFetchingChallenges.value
                        ? Container(
                            width: Helper.of(context).getScreenWidth(),
                            child: Card(
                              elevation: 5.0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Constants.upcomingChallenges,
                                      style: Helper.of(context).textStyle(
                                          color: Theme.of(context).primaryColor,
                                          font: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                        "You have no challenges to meet. Hurrah!"),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : UpcomingChallengesWidget(_con.upComingChallenges);
              }),
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
