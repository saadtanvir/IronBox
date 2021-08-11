import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ironbox/src/controllers/user_controller.dart';
import 'package:ironbox/src/models/reviews.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/T_trainerProfileCardWidget.dart';
import 'package:ironbox/src/widgets/playYoutubeVideoWidget.dart';
import 'package:ironbox/src/widgets/reviewCardWidget.dart';
import 'package:ironbox/src/widgets/showReviews.dart';
import 'package:ironbox/src/widgets/trainerProfileDetails.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;
import 'loadingWidgets/categoriesLoadingWidget.dart';

class TrainerProfileDetails extends StatefulWidget {
  final User trainer;
  const TrainerProfileDetails({Key key, @required this.trainer})
      : super(key: key);

  @override
  _TrainerProfileDetailsState createState() => _TrainerProfileDetailsState();
}

class _TrainerProfileDetailsState extends State<TrainerProfileDetails> {
  UserController _con = Get.put(UserController());
  DateFormat _dateFormatter;

  void onReviewTap(Review review) {
    // calls when a review taps
  }

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
            TrainerProfileDetailsWidget(trainer: widget.trainer),
            const SizedBox(
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
                    const EdgeInsets.symmetric(horizontal: 50.0),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  overlayColor: MaterialStateProperty.all(
                    Theme.of(context).accentColor.withOpacity(0.3),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
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
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
