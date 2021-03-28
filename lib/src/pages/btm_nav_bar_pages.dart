import 'package:fitness_app/src/pages/dietPackages.dart';
import 'package:fitness_app/src/pages/home.dart';
import 'package:fitness_app/src/pages/trainingPackages.dart';
import 'package:fitness_app/src/pages/workoutPackages.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarPages extends StatefulWidget {
  int currentTab;
  Widget currentPage = Home();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
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
            widget.currentPage = Home();
          }
          break;
        case 1:
          {
            widget.currentPage = TrainingPackages();
          }
          break;
        case 2:
          {
            widget.currentPage = WorkoutPackages();
          }
          break;
        case 3:
          {
            widget.currentPage = DietPackages();
          }
          break;
        case 4:
          {
            widget.currentPage = Center(child: Text("logs"));
            // widget.currentPage =
            //     FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          }
          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _selectTab(widget.currentTab);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      body: widget.currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        // selectedFontSize: 10,
        // unselectedFontSize: 10,
        // iconSize: 22,
        elevation: 0,
        backgroundColor: Colors.white,
        // selectedIconTheme: IconThemeData(size: 25),
        unselectedItemColor: Theme.of(context).secondaryHeaderColor,
        currentIndex: widget.currentTab,
        onTap: (int i) {
          print("icon tapped $i");
          this._selectTab(i);
        },
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
