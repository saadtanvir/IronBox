import 'package:ironbox/src/controllers/T_homeController.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/pages/logs.dart';
import 'package:ironbox/src/pages/messages.dart';
import 'package:ironbox/src/widgets/conversationsListWidget.dart';
import 'package:ironbox/src/widgets/showMessageIconWidget.dart';
import 'package:ironbox/src/widgets/trainerClientsList.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowClientsDetails extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  const ShowClientsDetails({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _ShowClientsDetailsState createState() => _ShowClientsDetailsState();
}

class _ShowClientsDetailsState extends State<ShowClientsDetails> {
  TrainerHomeController _con = Get.put(TrainerHomeController());

  void onClientTap(User client) {
    // go to logs
    Get.to(
      LogsScreen(
        canDelete: false,
        canUpdate: false,
        logUserId: client.id,
      ),
      transition: Transition.rightToLeft,
    );
  }

  @override
  void initState() {
    _con.getClientsList(userRepo.currentUser.value.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Clients",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.notes_rounded,
              color: Theme.of(context).accentColor),
          onPressed: () {
            widget.parentScaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return _con.clients.isEmpty && !_con.doneFetchingClients.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _con.clients.isEmpty && _con.doneFetchingClients.value
                      ? Center(
                          child: Text("You have no clients !"),
                        )
                      : TrainerClientsList(_con.clients, onClientTap);
            }),
          ],
        ),
      ),
    );
  }
}
