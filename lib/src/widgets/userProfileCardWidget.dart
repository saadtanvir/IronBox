import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';
import '../widgets/imageDialogWidget.dart';
import '../models/user.dart';

class UserProfileCardWidget extends StatelessWidget {
  final User user;
  final bool isTrainer;
  const UserProfileCardWidget(this.user, this.isTrainer, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.zero,
      color: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    // show picture in dialogue
                    Get.dialog(ImageDialogWidget("${user.avatar}"));
                  },
                  child: UserCircularAvatar(
                      height: 120.0,
                      width: 100.0,
                      imgUrl: "${user.avatar}",
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
                      "${user.name}",
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "${user.userName}",
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        // fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    isTrainer
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${user.userRating.rating}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15.0,
                              ),
                            ],
                          )
                        : const SizedBox(
                            height: 0.0,
                            width: 0.0,
                          ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50.0,
            ),
            isTrainer
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "\$${user.price}/mo",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 0.0,
                    width: 0.0,
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
