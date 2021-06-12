import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/subscriptions.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/T_trainerProfileDetails.dart';
import 'package:ironbox/src/widgets/showMessageIconWidget.dart';
import 'package:ironbox/src/widgets/subscribedTrainerProfile.dart';
import 'package:ironbox/src/widgets/trainersListWidget.dart';
import 'package:ironbox/src/widgets/userSubscribedTrainersListWidget.dart';
import '../controllers/user_controller.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;

class SubscribedTrainers extends StatefulWidget {
  const SubscribedTrainers({Key key}) : super(key: key);

  @override
  _SubscribedTrainersState createState() => _SubscribedTrainersState();
}

class _SubscribedTrainersState extends State<SubscribedTrainers> {
  UserController _con = Get.put(UserController());

  void onTrainerTap(Subscription sub) {
    // go to trainer profile details page
    print(sub.trainers.name);
    Get.to(
        SubscribedTrainerProfile(
          sub,
        ),
        transition: Transition.rightToLeft);
  }

  @override
  void initState() {
    _con.fetchUserSubscriptions(userRepo.currentUser.value.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          Constants.trainers,
          style: TextStyle(
              // color: Theme.of(context).primaryColor,
              ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshUserSubscriptions,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Obx(() {
                return _con.subscriptions.isEmpty &&
                        _con.doneFetchingSubscriptions.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Center(
                          child:
                              Text("You have not subscribed any Trainer yet !"),
                        ),
                      )
                    : _con.subscriptions.isEmpty &&
                            !_con.doneFetchingSubscriptions.value
                        ? Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : UserSubscribedTrainersListWidget(
                            _con.subscriptions, onTrainerTap);
              })
            ],
          ),
        ),
      ),
    );
  }
}
