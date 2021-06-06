import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:ironbox/src/repositories/user_repo.dart' as userRepo;

class UserProfilePage extends StatefulWidget {
  final User user;
  final bool isTrainer;
  const UserProfilePage(this.user, this.isTrainer, {Key key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
