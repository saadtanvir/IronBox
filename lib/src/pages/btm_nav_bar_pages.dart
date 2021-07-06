import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/pages/dietPackages.dart';
import 'package:ironbox/src/pages/home.dart';
import 'package:ironbox/src/pages/logs.dart';
import 'package:ironbox/src/pages/showTrainers.dart';
import 'package:ironbox/src/pages/trainingPackages.dart';
import 'package:ironbox/src/pages/workoutPackages.dart';
import 'package:ironbox/src/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import '../helpers/app_constants.dart' as Constants;

class BottomNavigationBarPages extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentTab;
  Widget currentPage = Home();
  BottomNavigationBarPages({this.currentTab}) {
    if (currentTab == null) {
      currentTab = 0;
    }
  }

  @override
  _BottomNavigationBarPagesState createState() =>
      _BottomNavigationBarPagesState();
}

class _BottomNavigationBarPagesState extends State<BottomNavigationBarPages> {
  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          {
            print("Displaying Home Page from btm nav");
            widget.currentPage = Home(
              parentScaffoldKey: widget.scaffoldKey,
            );
          }
          break;
        case 1:
          {
            // app category index is 0
            // and name is training
            // widget.currentPage = TrainingPackages(
            //   Constants.appCategoriesName[0],
            //   parentScaffoldKey: widget.scaffoldKey,
            // );
            widget.currentPage = ShowTrainers(
              parentScaffoldKey: widget.scaffoldKey,
            );
          }
          break;
        case 2:
          {
            // show subcategories
            // show child categories
            // for now on, only show plans

            widget.currentPage = WorkoutPackages(
              Constants.appCategoriesName[1],
              parentScaffoldKey: widget.scaffoldKey,
            );
          }
          break;
        case 3:
          {
            // widget.currentPage = DietPackages(
            //   Constants.appCategoriesName[2],
            //   parentScaffoldKey: widget.scaffoldKey,
            // );
          }
          break;
        case 4:
          {
            // widget.currentPage = Center(child: Text("logs"));
            widget.currentPage = LogsScreen(
              parentScaffoldKey: widget.scaffoldKey,
            );
          }
          break;
      }
    });
  }

  @override
  void initState() {
    print("inside btm nav init function");
    print("current tab: ${widget.currentTab}");
    _selectTab(widget.currentTab);
    super.initState();
  }

  // Link:
  // https://stackoverflow.com/questions/52598900/flutter-bottomnavigationbar-rebuilds-page-on-change-of-tab

  @override
  Widget build(BuildContext context) {
    // call this func
    // so that widget rebuilds properly
    // print("current tab: ${widget.currentTab}");
    // _selectTab(widget.currentTab);
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
          _bottomNavBarItem(icon: Icon(Icons.home_outlined)),
          _bottomNavBarItem(icon: Icon(Icons.show_chart)),
          _bottomNavBarItem(icon: Icon(Icons.fitness_center)),
          _bottomNavBarItem(icon: Icon(Icons.restaurant_outlined)),
          _bottomNavBarItem(icon: Icon(Icons.event_outlined))
        ],
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBarItem({@required Widget icon}) {
    return BottomNavigationBarItem(icon: icon, label: "");
  }
}
