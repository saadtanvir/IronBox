import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/subscriptions.dart';
import 'package:ironbox/src/widgets/dialogs/ratingReviewsDialog.dart';
import 'package:ironbox/src/widgets/dialogs/trainerUnsubBottomSheet.dart';
// import 'package:timer_count_down/timer_controller.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';
import '../widgets/loadingWidgets/categoriesLoadingWidget.dart';
import '../widgets/playYoutubeVideoWidget.dart';
import '../widgets/reviewCardWidget.dart';
import '../widgets/showTrainerReviews.dart';
import '../widgets/subscribedTrainerProfileCardWidget.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
// import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class SubscribedTrainerProfile extends StatefulWidget {
  final Subscription subscription;
  const SubscribedTrainerProfile(this.subscription, {Key key})
      : super(key: key);

  @override
  _SubscribedTrainerProfileState createState() =>
      _SubscribedTrainerProfileState();
}

class _SubscribedTrainerProfileState extends State<SubscribedTrainerProfile> {
  UserController _con = Get.put(UserController());
  CountdownTimerController countdownTimeController;
  DateTime subscriptionEndDate;

  void onEnd() {
    print('onEnd');
    countdownTimeController.disposeTimer();
    _con.unsubscribeTrainer(context, widget.subscription).then((value) {
      // take review and ratings here
      // Get.to(TrainerRatingReviewsDialog(widget.subscription));
    });
  }

  @override
  void initState() {
    _con.getTrainerReviews(widget.subscription.trainers.id);
    subscriptionEndDate = DateTime.parse(widget.subscription.endDate);
    print(subscriptionEndDate);
    countdownTimeController = CountdownTimerController(
        endTime: subscriptionEndDate.millisecondsSinceEpoch + 1000 * 30,
        onEnd: onEnd);
    countdownTimeController.start();
    super.initState();
  }

  @override
  void dispose() {
    countdownTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.subscription.trainers.name}",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubscribedTrainerProfileCardWidget(
              widget.subscription.trainers,
            ),
            SizedBox(
              height: 10.0,
            ),
            // show the countdown
            CountdownTimer(
              controller: countdownTimeController,
              widgetBuilder: (context, CurrentRemainingTime time) {
                // print(time.toString());
                return time == null
                    ? SizedBox(
                        height: 0.0,
                        width: 0.0,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: time.days == null
                                    ? Text(
                                        "00",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      )
                                    : Text(
                                        time.days.toString(),
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 30.0,
                              // color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: time.hours == null
                                    ? Text(
                                        "00",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      )
                                    : Text(
                                        time.hours.toString(),
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 30.0,
                              // color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: time.min == null
                                    ? Text(
                                        "00",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      )
                                    : Text(
                                        time.min.toString(),
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 30.0,
                              // color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: time.sec == null
                                    ? Text(
                                        "00",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      )
                                    : Text(
                                        time.sec.toString(),
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${Constants.specializesIn}",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          elevation: 10.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                "${widget.subscription.trainers.specializesIn}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${Constants.experience}",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          elevation: 10.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                "${widget.subscription.trainers.experience} year/s",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "${Constants.description}:",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                color: Colors.white,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Text(
                    "${widget.subscription.trainers.description}",
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.grey[700],
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "${Constants.reviews}:",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextButton(
                    onPressed: () async {
                      if (_con.reviews.isNotEmpty) {
                        Get.to(
                            TrainerReviewsList(_con.reviews.reversed.toList()),
                            transition: Transition.rightToLeft);
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      overlayColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor.withOpacity(0.3),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    child: Text(
                      "${Constants.view_all}",
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Obx(() {
                return _con.reviews.isEmpty && _con.doneFetchingReviews.value
                    ? Text(
                        "No reviews",
                      )
                    : _con.reviews.isEmpty && !_con.doneFetchingReviews.value
                        ? CategoriesLoadingWidget(
                            cardCount: 1,
                          )
                        : ReviewCardWidget(_con.reviews.last);
              }),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PlayYoutubeVideoWidget(
                "https://www.youtube.com/watch?v=f8fv4FuYyqM",
                width: 390,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () async {
                  // ask for rating and reviews
                  // delete from firebase messages
                  // delete from firebase contacts
                  // call unsub

                  // Get.dialog(TrainerRatingReviewsDialog(widget.subscription),
                  //     transitionDuration: new Duration(milliseconds: 200));
                  Get.bottomSheet(
                    TrainerUnsubBottomSheet(widget.subscription),
                    isDismissible: false,
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 50.0),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  overlayColor: MaterialStateProperty.all(
                    Theme.of(context).accentColor.withOpacity(0.3),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                child: Text(
                  Constants.unsubscribe,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
