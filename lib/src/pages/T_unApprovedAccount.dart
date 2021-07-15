import '../controllers/user_controller.dart';
import '../models/user.dart';
import '../widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TrainerUnApprovedAccount extends StatefulWidget {
  @override
  _TrainerUnApprovedAccountState createState() =>
      _TrainerUnApprovedAccountState();
}

class _TrainerUnApprovedAccountState extends State<TrainerUnApprovedAccount> {
  GlobalKey<ScaffoldState> k;
  UserController _con = Get.put(UserController());
  var isRefreshing = false.obs;

  Future<void> checkUserAccountStatus() async {
    _con
        .getUpdatedCurrentUser(userRepo.currentUser.value.id)
        .then((User _user) {
      isRefreshing.value = false;
      if (_user.accountStatus == 1) {
        Get.offAllNamed('/TrainerBtmNavBar');
      }
    });
  }

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
        title: const Image(
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
        actions: [
          Obx(() {
            return !isRefreshing.value
                ? IconButton(
                    onPressed: () {
                      isRefreshing.value = true;
                      checkUserAccountStatus();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SpinKitCircle(
                      color: Theme.of(context).primaryColor,
                      size: 24.0,
                    ));
          })
        ],
      ),
      drawer: DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: checkUserAccountStatus,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: const EdgeInsets.all(5.0),
              child: const Text(
                "Your trainer account is not approved by the admin yet !",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
