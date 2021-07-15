import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';
import '../widgets/showMessageIconWidget.dart';
import '../widgets/trainersListWidget.dart';
import '../controllers/user_controller.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;

class ShowTrainers extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  // final String category;
  ShowTrainers({this.parentScaffoldKey});
  @override
  _ShowTrainersState createState() => _ShowTrainersState();
}

class _ShowTrainersState extends State<ShowTrainers> {
  UserController _con = Get.put(UserController());

  void onTrainerTap(User trainer) async {
    // check whether trainer is subscribed or not
    // if yes go to subscribed trainer profile
    // if no then go to trainer profile page
    print(trainer.name);

    _con.checkIsTrainerSubscribed(context,
        uid: userRepo.currentUser.value.id,
        trainerId: trainer.id,
        trainer: trainer);
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
      body: RefreshIndicator(
        onRefresh: _con.fetchAllTrainers,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Obx(() {
                return _con.trainers.isEmpty && _con.doneFetchingTrainers.value
                    ? const Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: const Center(
                          child: const Text("No trainers found. Try again !"),
                        ),
                      )
                    : _con.trainers.isEmpty && !_con.doneFetchingTrainers.value
                        ? const Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: const Center(
                                child: const CircularProgressIndicator()),
                          )
                        : TrainersListWidget(_con.trainers, onTrainerTap);
              })
            ],
          ),
        ),
      ),
    );
  }
}
