import 'package:ironbox/src/controllers/dietSection_controller.dart';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/helpers/app_constants.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/pages/requestDietPlanScreen.dart';
import 'package:ironbox/src/widgets/trainersListWidget.dart';
import '../helpers/app_constants.dart' as Constants;

class DietSection extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  const DietSection({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _DietSectionState createState() => _DietSectionState();
}

class _DietSectionState extends State<DietSection> {
  DietSectionController _con = Get.put(DietSectionController());

  void onDiettitianTap(User dietitian) {
    // show trainer details
    // with request custom plan button
    Get.to(RequestDietPlanScreen(trainer: dietitian));
  }

  @override
  void initState() {
    _con.getDietitians();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Select Trainer",
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
        // actions: [
        //   MessageIconWidget(),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return _con.dietitiansList.isEmpty &&
                      _con.doneFetchingDietitians.value
                  ? const Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: const Center(
                        child: const Text("No trainers found. Try again !"),
                      ),
                    )
                  : _con.dietitiansList.isEmpty &&
                          !_con.doneFetchingDietitians.value
                      ? const Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: const Center(
                              child: const CircularProgressIndicator()),
                        )
                      : TrainersListWidget(
                          _con.dietitiansList, onDiettitianTap);
            }),
          ],
        ),
      ),
    );
  }
}
