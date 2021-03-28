import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/widgets/loginWidget.dart';
import 'package:fitness_app/src/widgets/signupWidget.dart';
import 'package:flutter/material.dart';
import '../helpers/app_constants.dart' as Constants;

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabbarOptions;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabbarOptions = Constants.tabbarOptions;
    _tabController =
        new TabController(length: _tabbarOptions.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              backgroundColor: Constants.primaryColor,
              expandedHeight: Helper.of(context).getScreenHeight() * 0.65,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/img/logo.png"),
                      width: Helper.of(context).getScreenWidth() * 0.54,
                      height: Helper.of(context).getScreenHeight() * 0.25,
                    ),
                    SizedBox(height: 30.0),
                    Image(
                      image: AssetImage("assets/img/create_acc_message.png"),
                      width: Helper.of(context).getScreenWidth() * 0.54,
                      height: Helper.of(context).getScreenHeight() * 0.25,
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                tabs: _tabbarOptions.map((option) {
                  return Tab(
                    child: Text("$option"),
                  );
                }).toList(),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: _tabbarOptions.map((String option) {
            switch (option) {
              case "Sign Up":
                {
                  return SignUpWidget();
                }
                break;
              case "Log In":
                {
                  // move to login screen
                  return LoginWidget();
                }
                break;
              default:
                {
                  return SignUpWidget();
                }
                break;
            }
          }).toList(),
        ),
      ),
    );
  }
}
