import 'package:fitness_app/src/widgets/loginWidget.dart';
import 'package:fitness_app/src/widgets/signupWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_app/src/helpers/helper.dart';
import '../helpers/app_constants.dart' as Constants;

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> _tabbarOptions;

  @override
  void initState() {
    // TODO: implement initState
    _tabbarOptions = Constants.tabbarOptions;
    _tabController =
        new TabController(length: _tabbarOptions.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Helper.of(context).getScreenHeight() * 0.65,
        centerTitle: true,
        title: Column(
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
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabbarOptions.map((option) {
            return Tab(
              child: Text("$option"),
            );
          }).toList(),
        ),
      ),
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
    );
  }
}
