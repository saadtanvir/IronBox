import 'package:flutter/material.dart';
import 'package:ironbox/src/models/subscriptions.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/subscribedTrainersListTile.dart';
import 'package:ironbox/src/widgets/trainerListTileWidget.dart';

class UserSubscribedTrainersListWidget extends StatefulWidget {
  final List<Subscription> subscriptions;
  final Function onTap;
  const UserSubscribedTrainersListWidget(this.subscriptions, this.onTap,
      {Key key})
      : super(key: key);

  @override
  _UserSubscribedTrainersListWidgetState createState() =>
      _UserSubscribedTrainersListWidgetState();
}

class _UserSubscribedTrainersListWidgetState
    extends State<UserSubscribedTrainersListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70 * widget.subscriptions.length.toDouble(),
      // color: Colors.blue,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.subscriptions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                // go on trainer profile details page
                widget.onTap(widget.subscriptions[index]);
              },
              child: SubscribedTrainerListTile(widget.subscriptions[index]));
        },
      ),
    );
  }
}
