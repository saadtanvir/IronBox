import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/T_trainerProfileDetails.dart';
import 'package:ironbox/src/widgets/showMessageIconWidget.dart';
import 'package:ironbox/src/widgets/trainersListWidget.dart';
import '../controllers/user_controller.dart';
import '../helpers/app_constants.dart' as Constants;

class ShowTrainers extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  final String category;
  ShowTrainers(this.category, {this.parentScaffoldKey});
  @override
  _ShowTrainersState createState() => _ShowTrainersState();
}

class _ShowTrainersState extends State<ShowTrainers> {
  UserController _con = Get.put(UserController());

  void onTrainerTap(User trainer) {
    // go to trainer profile details page
    print(trainer.name);
    Get.to(TrainerProfileDetails(
      trainer: trainer,
    ));
  }

  @override
  void initState() {
    _con.fetchAllTrainers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          Constants.trainers,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.notes_rounded,
              color: Theme.of(context).accentColor),
          onPressed: () {
            // open drawer from pages file
            // using parent key
            widget.parentScaffoldKey.currentState.openDrawer();
          },
        ),
        actions: [
          MessageIconWidget(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return _con.trainers.isEmpty && _con.doneFetchingTrainers.value
                  ? Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Center(
                        child: Text("No trainers found. Try again !"),
                      ),
                    )
                  : _con.trainers.isEmpty && !_con.doneFetchingTrainers.value
                      ? Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : TrainersListWidget(_con.trainers, onTrainerTap);
            })
          ],
        ),
      ),
    );
  }
}
