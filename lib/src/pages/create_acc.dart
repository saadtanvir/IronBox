import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/pages/signup.dart';
import 'package:ironbox/src/pages/stepper_signup.dart';
import 'package:ironbox/src/widgets/loginWidget.dart';
import 'package:ironbox/src/widgets/signupWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      image: const AssetImage("assets/img/logo.png"),
                      width: Helper.of(context).getScreenWidth() * 0.54,
                      height: Helper.of(context).getScreenHeight() * 0.25,
                    ),
                    const SizedBox(height: 30.0),
                    Image(
                      image:
                          const AssetImage("assets/img/create_acc_message.png"),
                      width: Helper.of(context).getScreenWidth() * 0.54,
                      height: Helper.of(context).getScreenHeight() * 0.25,
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                onTap: (index) {
                  if (index == 0) {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  }
                },
                tabs: _tabbarOptions.map((option) {
                  return Tab(
                    child: Text(
                      "$option",
                      style:
                          Helper.of(context).textStyle(font: FontWeight.bold),
                    ),
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
                  print("switching to signup");
                  return _signupButton();
                }
                break;
              case "Log In":
                {
                  print("switching to login");
                  return LoginWidget();
                }
                break;
              default:
                {
                  print("switching to signup");
                  return _signupButton();
                }
                break;
            }
          }).toList(),
        ),
      ),
    );
  }

  Widget _signupButton() {
    return Container(
      height: 20.0,
      color: Theme.of(context).accentColor,
      child: Center(
        child: TextButton(
          onPressed: () {
            print("Get.to(Signup form)");
            Get.to(StepperSignup());
          },
          child: Text(
            Constants.signup_with_email,
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0)),
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).scaffoldBackgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
