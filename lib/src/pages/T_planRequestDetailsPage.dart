import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/planRequest.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;

class TrainerPlanRequestDetailsPage extends StatefulWidget {
  final PlanRequest request;
  const TrainerPlanRequestDetailsPage({Key key, @required this.request})
      : super(key: key);

  @override
  _TrainerPlanRequestDetailsPageState createState() =>
      _TrainerPlanRequestDetailsPageState();
}

class _TrainerPlanRequestDetailsPageState
    extends State<TrainerPlanRequestDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text("Request Details"),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: Helper.of(context).getScreenHeight() * 0.40,
              width: Helper.of(context).getScreenWidth(),
              padding: EdgeInsets.only(
                top: 50.0,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Request Details",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: UserCircularAvatar(
                      imgUrl: widget.request.user.avatar,
                      adjustment: BoxFit.fill,
                      height: 70.0,
                      width: 70.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${widget.request.user.name}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.request.user.age}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        " | ",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${widget.request.user.gender}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: Helper.of(context).getScreenHeight() * 0.35,
            left: 30.0,
            right: 30.0,
            child: Container(
              width: Helper.of(context).getScreenWidth(),
              constraints: BoxConstraints(
                minHeight: 70.0,
              ),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "${widget.request.user.weight}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Weight",
                      )
                    ],
                  ),
                  Text(
                    "    |    ",
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "${widget.request.user.height}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Height",
                      )
                    ],
                  ),
                  Text(
                    "    |    ",
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        Helper.getUserBMI(widget.request.user.height,
                            widget.request.user.weight),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "BMI",
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
