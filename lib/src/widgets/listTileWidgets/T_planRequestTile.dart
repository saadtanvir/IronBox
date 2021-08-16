import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/planRequest.dart';
import 'package:ironbox/src/widgets/userCircularAatar.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

class TrainerPlanRequestTile extends StatelessWidget {
  final PlanRequest request;
  const TrainerPlanRequestTile({Key key, @required this.request})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      minVerticalPadding: 0.0,
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      focusColor: Colors.amber,
      leading: UserCircularAvatar(
        imgUrl: request.user.avatar,
        adjustment: BoxFit.fill,
        height: 60.0,
        width: 60.0,
      ),
      title: Text("${request.user.name}"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${request.dateRequested}",
            style: const TextStyle(
              fontSize: 13.0,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          request.paymentStatus == 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 8.0,
                      child: const Center(
                        child: const Icon(
                          Icons.done_rounded,
                          color: Colors.white,
                          size: 15.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    const Text(
                      "Payment verified",
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    )
                  ],
                )
              : const SizedBox(
                  height: 0.0,
                  width: 0.0,
                )
        ],
      ),
      trailing: Text(
        "\$${request.price}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
