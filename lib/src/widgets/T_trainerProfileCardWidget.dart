import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';
import '../widgets/imageDialogWidget.dart';
import '../widgets/userCircularAatar.dart';

class TrainerProfileCardWidget extends StatelessWidget {
  final User trainer;
  const TrainerProfileCardWidget({Key key, this.trainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.zero,
      color: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
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
                  const SizedBox(
                    width: 15.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      // show picture in dialogue
                      Get.dialog(ImageDialogWidget("${trainer.avatar}"));
                    },
                    child: UserCircularAvatar(
                        height: 120.0,
                        width: 100.0,
                        imgUrl: "${trainer.avatar}",
                        adjustment: BoxFit.fill),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    children: [
                      const SizedBox(
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
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${trainer.userRating.rating.toStringAsFixed(1)}",
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15.0,
                          ),
                          Text(
                            " (${trainer.userRating.totalCount})",
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "\$${trainer.price}/mo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
