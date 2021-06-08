import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/chattingScreenWidget.dart';
import '../models/user.dart';
import '../widgets/imageDialogWidget.dart';
import '../widgets/playYoutubeVideoWidget.dart';
import '../widgets/userCircularAatar.dart';
import '../helpers/app_constants.dart' as Constants;

class SubscribedTrainerProfileCardWidget extends StatelessWidget {
  final User trainer;
  const SubscribedTrainerProfileCardWidget(this.trainer, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.zero,
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Container(
                // height: 200,
                // color: Colors.blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        // show picture in dialogue
                        Get.dialog(ImageDialogWidget("${trainer.avatar}"));
                      },
                      child: UserCircularAvatar(
                          120.0, 100.0, "${trainer.avatar}", BoxFit.fill),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "${trainer.name}",
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${trainer.userRating.rating}",
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 15.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () async {
                        Get.to(ChattingScreen(
                            trainer.id, trainer.avatar, trainer.userName));
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).scaffoldBackgroundColor),
                        overlayColor: MaterialStateProperty.all(
                          Theme.of(context).accentColor.withOpacity(0.3),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                      ),
                      child: Text(
                        "Message",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 30.0,
                  // ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "\$${trainer.price}/mo",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
