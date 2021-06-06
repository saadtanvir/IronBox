import 'package:ironbox/src/controllers/T_homeController.dart';
import 'package:ironbox/src/widgets/conversationsListWidget.dart';
import 'package:ironbox/src/widgets/showMessageIconWidget.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerHomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  TrainerHomePage({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _TrainerHomePageState createState() => _TrainerHomePageState();
}

class _TrainerHomePageState extends State<TrainerHomePage> {
  // show clients list on this page
  TrainerHomeController _con = Get.put(TrainerHomeController());
  @override
  void initState() {
    if (userRepo.currentUser.value.userToken != null) {
      _con.getClientsList(userRepo.currentUser.value.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        // if you want to add some other
        // widget on the screen
        // wrap children in column
        child: Obx(() {
          return _con.clients.isEmpty && !_con.doneFetchingClients.value
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              : _con.clients.isEmpty && _con.doneFetchingClients.value
                  ? Center(
                      heightFactor: 20.0,
                      child: Text(
                        "You do not have any client !",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ConversationsListWidget(_con.clients);
        }),
      ),
    );
  }
}
