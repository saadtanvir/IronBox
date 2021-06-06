import 'package:ironbox/src/models/plan.dart';
import 'package:ironbox/src/pages/appPlanDetails.dart';
import 'package:ironbox/src/widgets/T_createPlanWidget.dart';
import 'package:ironbox/src/widgets/T_planDetailsWidget.dart';
import 'package:ironbox/src/widgets/plansListWidget.dart';
import 'package:ironbox/src/widgets/searchBarWidget.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainerPlans extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  TrainerPlans({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _TrainerPlansState createState() => _TrainerPlansState();
}

class _TrainerPlansState extends State<TrainerPlans> {
  PlansController _con = Get.put(PlansController());

  void planOnTap(Plan p) {
    Get.to(TrainerPlanDetailsWidget(p));
  }

  @override
  void initState() {
    if (userRepo.currentUser.value.userToken != null) {
      _con.getTrainerPlans(userRepo.currentUser.value.id);
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
      floatingActionButton: _floatingActionButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // pass onSubmit func
            // update the widget below
            // SearchBarWidget(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() {
                return _con.plans.isEmpty && !_con.doneFetchingPlans.value
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor),
                        ),
                      )
                    : _con.plans.isEmpty && _con.doneFetchingPlans.value
                        ? Center(
                            heightFactor: 20.0,
                            child: Text(
                              "You have not created any plan yet !",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : PlansListWidget(
                            _con.plans.reversed.toList(), planOnTap);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(
          TrainerCreatePlanWidget(),
          fullscreenDialog: true,
        );
      },
      child: Icon(
        Icons.add,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      splashColor: Theme.of(context).accentColor.withOpacity(0.5),
    );
  }
}
