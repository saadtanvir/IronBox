import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ironbox/src/controllers/user_controller.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/T_trainerProfileCardWidget.dart';
import 'package:ironbox/src/widgets/playYoutubeVideoWidget.dart';
import 'package:ironbox/src/widgets/reviewCardWidget.dart';
import 'package:ironbox/src/widgets/showTrainerReviews.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
import 'loadingWidgets/categoriesLoadingWidget.dart';

class TrainerProfileDetails extends StatefulWidget {
  final User trainer;
  const TrainerProfileDetails({Key key, this.trainer}) : super(key: key);

  @override
  _TrainerProfileDetailsState createState() => _TrainerProfileDetailsState();
}

class _TrainerProfileDetailsState extends State<TrainerProfileDetails> {
  UserController _con = Get.put(UserController());
  DateFormat _dateFormatter;

  @override
  void initState() {
    _con.getTrainerReviews(widget.trainer.id);
    _dateFormatter = DateFormat(Constants.dateStringFormat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.trainer.name}",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TrainerProfileCardWidget(
              trainer: widget.trainer,
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
                                "${widget.trainer.specializesIn}",
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
                                "${widget.trainer.experience} year/s",
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
                  child: Center(
                    child: Text(
                      "${widget.trainer.description}",
                      style: TextStyle(
                        height: 1.5,
                        color: Colors.grey[700],
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
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
                        Get.to(TrainerReviewsList(_con.reviews),
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
                width: 350,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () async {
                  _con.subscription.startDate =
                      _dateFormatter.format(DateTime.now());
                  _con.subscription.endDate = _dateFormatter
                      .format(DateTime.now().add(new Duration(days: 30)));
                  _con.subscription.subPrice =
                      double.parse(widget.trainer.price);
                  _con.subscription.status = "1";
                  _con.subscription.trainerId = widget.trainer.id;
                  _con.subscription.traineeId = userRepo.currentUser.value.id;
                  // before subscribing trainer, verify payment
                  _con.subscribeTrainer(context);
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
                  Constants.subscribe,
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
