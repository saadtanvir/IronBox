import 'package:ironbox/src/helpers/connectionState.dart';

import '../widgets/loadingWidgets/categoriesLoadingWidget.dart';
import '../controllers/home_controller.dart';
import '../helpers/helper.dart';
import '../widgets/categoriesWidget.dart';
import '../widgets/recommendedCarousel.dart';
import '../widgets/upcomingChallengesCardWidget.dart';
import '../widgets/showMessageIconWidget.dart';
import '../widgets/userDetailsCardWidget.dart';
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

  @override
  void initState() {
    // _con.listenForStepCount();
    // _con.checkActivityRecognitionPermission();
    // _con.checkBodySensorPermission();
    // _con.listenForCategories();
    // _con.getSubCategories();
    // _con.getChildCategories();
    print("inside init of Home Page");
    _dateFormatter = DateFormat(Constants.dateStringFormat);
    currentDate = _dateFormatter.format(DateTime.now());
    if (userRepo.currentUser.value.userToken != null &&
        userRepo.currentUser.value.userToken.isNotEmpty) {
      _con.getUpComingChallenges(userRepo.currentUser.value.id, currentDate);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("sub cat length:");
    print(Constants.subCategories.length);
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
        actions: [
          MessageIconWidget(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          // setState(() {});
          return _con.refreshHome();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                print("Total observable steps: ${_con.steps.value}");
                return _con.steps.value >= 0
                    ? UserDetailsCardWidget(
                        userRepo.currentUser.value,
                        _con.steps.value,
                      )
                    : UserDetailsCardWidget(
                        userRepo.currentUser.value,
                        _con.steps.value,
                      );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Constants.upcomingChallenges,
                                        style: Helper.of(context).textStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            font: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(Constants
                                          .you_have_no_challenges_to_meet_hurrah),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : UpcomingChallengesWidget(_con.upComingChallenges);
                }),
              ),
              Obx(() {
                return _con.categories.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CategoriesLoadingWidget(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CategoriesWidget(_con.categories),
                      );
              }),
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
      ),
    );
  }

  // to maintain the state of page in
  // bottom navigation
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
