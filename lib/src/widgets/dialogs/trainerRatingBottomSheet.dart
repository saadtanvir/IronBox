import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ironbox/src/controllers/user_controller.dart';
import 'package:ironbox/src/models/subscriptions.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/widgets/dialogs/trainerUnsubBottomSheet.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

class TrainerRatingBottomSheet extends StatefulWidget {
  Subscription subscription;
  bool canGoBack;
  TrainerRatingBottomSheet(this.subscription, this.canGoBack, {Key key})
      : super(key: key);

  @override
  _TrainerRatingBottomSheetState createState() =>
      _TrainerRatingBottomSheetState();
}

class _TrainerRatingBottomSheetState extends State<TrainerRatingBottomSheet> {
  UserController _con = Get.put(UserController());
  final TextEditingController reviewController = new TextEditingController();
  int givenRating = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 250.0,
      // width: 250.0,
      // margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.0),
          topLeft: Radius.circular(15),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.canGoBack
                        ? GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.bottomSheet(
                                TrainerUnsubBottomSheet(widget.subscription),
                                isDismissible: false,
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.red,
                            ),
                          )
                        : SizedBox(
                            height: 0.0,
                            width: 0.0,
                          ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (givenRating > 1) {
                          // post rating then unsub
                          _con
                              .rateTrainer(
                                  givenRating, widget.subscription.trainers.id)
                              .then((value) {
                            print(value);
                            if (value) {
                              print("trainer rated successfully");
                              _con.unsubscribeTrainer(
                                  context, widget.subscription);
                            }
                          });
                        } else {
                          // unsub
                          _con.unsubscribeTrainer(context, widget.subscription);
                        }
                      },
                      child: Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                "Rate ${widget.subscription.trainers.name}",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              RatingBar.builder(
                minRating: 0.0,
                maxRating: 5.0,
                allowHalfRating: false,
                glowColor: Colors.yellow,
                itemSize: 30.0,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.star,
                    color: Colors.yellow,
                  );
                },
                onRatingUpdate: (rating) {
                  print(rating);
                  givenRating = rating.toInt();
                },
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
