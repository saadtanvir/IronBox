import 'package:flutter/material.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/trainerListTileWidget.dart';

class TrainersListWidget extends StatefulWidget {
  final List<User> trainers;
  final Function onTap;
  TrainersListWidget(this.trainers, this.onTap);

  @override
  _TrainersListWidgetState createState() => _TrainersListWidgetState();
}

class _TrainersListWidgetState extends State<TrainersListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70 * widget.trainers.length.toDouble(),
      // color: Colors.blue,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.trainers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                // go on trainer profile details page
                widget.onTap(widget.trainers[index]);
              },
              child: TrainerListTile(widget.trainers[index]));
        },
      ),
    );
  }
}
