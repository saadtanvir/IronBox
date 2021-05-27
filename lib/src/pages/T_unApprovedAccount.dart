import 'package:ironbox/src/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;

class TrainerUnApprovedAccount extends StatefulWidget {
  @override
  _TrainerUnApprovedAccountState createState() =>
      _TrainerUnApprovedAccountState();
}

class _TrainerUnApprovedAccountState extends State<TrainerUnApprovedAccount> {
  GlobalKey<ScaffoldState> k;

  @override
  void initState() {
    k = new GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: k,
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
            k.currentState.openDrawer();
          },
        ),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Container(
          child:
              Text("Your trainer account is not approved by the admin yet !"),
        ),
      ),
    );
  }
}
