import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/userWorkoutPlanGame.dart';
import 'package:ironbox/src/widgets/listTileWidgets/userWorkoutPlanGameTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/app_constants.dart' as Constants;

class UserWorkoutPlanGamesListWidget extends StatelessWidget {
  final List<UserWorkoutPlanGame> gamesList;
  final Function onGameTap;
  UserWorkoutPlanGamesListWidget(this.gamesList, this.onGameTap, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0 * gamesList.length.toDouble(),
      width: Helper.of(context).getScreenWidth(),
      // margin: EdgeInsets.all(5.0),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: gamesList.length,
        itemBuilder: (context, index) {
          // print("returing card widget");
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                onGameTap(gamesList[index]);
              },
              child: UserWOPGameTileWidget(gamesList[index]),
            ),
          );
        },
      ),
    );
  }
}
