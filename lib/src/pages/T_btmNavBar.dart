import 'package:ironbox/src/pages/T_homePage.dart';
import 'package:ironbox/src/pages/T_plans.dart';
import 'package:ironbox/src/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import '../helpers/app_constants.dart' as Constants;

class TrainerBottomNavBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentTab;
  Widget currentPage = TrainerHomePage();
  TrainerBottomNavBar({this.currentTab}) {
    if (currentTab == null) {
      currentTab = 1;
    }
  }
  @override
  _TrainerBottomNavBarState createState() => _TrainerBottomNavBarState();
}

class _TrainerBottomNavBarState extends State<TrainerBottomNavBar> {
  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          {
            widget.currentPage = TrainerPlans(
              parentScaffoldKey: widget.scaffoldKey,
            );
          }
          break;
        case 1:
          {
            // print("Displaying Home Page from btm nav");
            widget.currentPage = TrainerHomePage(
              parentScaffoldKey: widget.scaffoldKey,
            );
          }
          break;
        case 2:
          {
            // widget.currentPage =
            //     WorkoutPackages(Constants.appCategoriesName[1]);
          }
          break;
      }
    });
  }

  @override
  void initState() {
    print("inside T btm nav init function");
    _selectTab(widget.currentTab);
    super.initState();
  }

  // Link:
  // https://stackoverflow.com/questions/52598900/flutter-bottomnavigationbar-rebuilds-page-on-change-of-tab

  @override
  Widget build(BuildContext context) {
    // call this func
    // so that widget rebuilds properly
    _selectTab(widget.currentTab);
    return Scaffold(
      key: widget.scaffoldKey,
      drawer: DrawerWidget(),
      body: widget.currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentTab,
        onTap: (int i) {
          print("icon tapped $i");
          this._selectTab(i);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        elevation: 0,
        backgroundColor: Colors.white,
        unselectedItemColor: Theme.of(context).secondaryHeaderColor,
        items: [
          _bottomNavBarItem(icon: Icon(Icons.fitness_center)),
          _bottomNavBarItem(icon: Icon(Icons.people_rounded)),
          _bottomNavBarItem(icon: Icon(Icons.stacked_line_chart_rounded)),
          // _bottomNavBarItem(icon: Icon(Icons.event_outlined))
        ],
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBarItem({@required Widget icon}) {
    return BottomNavigationBarItem(icon: icon, label: "");
  }
}
