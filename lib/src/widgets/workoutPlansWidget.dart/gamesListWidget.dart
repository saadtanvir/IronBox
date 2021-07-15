import 'package:flutter/material.dart';
import 'package:ironbox/src/models/workoutPlanGame.dart';
import 'package:ironbox/src/widgets/listTileWidgets/workoutPlanGameTile.dart';
import '../../helpers/app_constants.dart' as Constants;

class WorkoutPlanGamesList extends StatelessWidget {
  final List<WorkoutPlanGame> gamesList;
  final Function onGameTap;
  WorkoutPlanGamesList(this.gamesList, this.onGameTap, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200 * gamesList.length.toDouble(),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: gamesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                onGameTap(gamesList[index]);
              },
              child: WorkoutPlanGameTile(gamesList[index]));
        },
      ),
    );
  }
}
