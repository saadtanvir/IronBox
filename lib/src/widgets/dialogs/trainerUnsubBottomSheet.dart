import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../controllers/user_controller.dart';
import '../../models/subscriptions.dart';
import 'package:get/get.dart';
import '../../helpers/app_constants.dart' as Constants;
import '../../repositories/user_repo.dart' as userRepo;

class TrainerUnsubBottomSheet extends StatefulWidget {
  Subscription subscription;
  TrainerUnsubBottomSheet(this.subscription, {Key key}) : super(key: key);

  @override
  _TrainerUnsubBottomSheetState createState() =>
      _TrainerUnsubBottomSheetState();
}

class _TrainerUnsubBottomSheetState extends State<TrainerUnsubBottomSheet> {
  UserController _con = Get.put(UserController());
  final TextEditingController reviewController = new TextEditingController();
  var isReviewEmpty = true.obs;
  int givenRating = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           Get.back();
              //           Get.bottomSheet(
              //             TrainerRatingBottomSheet(widget.subscription, true),
              //             isDismissible: false,
              //           );
              //         },
              //         child: Icon(
              //           Icons.arrow_forward,
              //           color: Colors.red,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 15.0),
              Text(
                "Share your experience with ${widget.subscription.trainers.name}:",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: reviewController,
                keyboardType: TextInputType.emailAddress,
                maxLines: null,
                // onChanged: (input) {
                //   if (input.length > 0) {
                //     isReviewEmpty.value = false;
                //   } else {
                //     isReviewEmpty.value = true;
                //   }
                // },
                decoration: InputDecoration(
                  labelText: "Write a review",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).accentColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Obx(() {
              //     return !isReviewEmpty.value
              //         ? TextButton(
              //             onPressed: () async {
              //               FocusScope.of(context)
              //                   .requestFocus(new FocusNode());
              //               _con
              //                   .postTrainerReview(
              //                       context: context,
              //                       trainerId: widget.subscription.trainers.id,
              //                       userId: userRepo.currentUser.value.id,
              //                       review: reviewController.text)
              //                   .then((value) {
              //                 if (value) {
              //                   print("review posted successfully");
              //                   Get.snackbar(
              //                     "Success!",
              //                     "Review posted successfully.",
              //                     backgroundColor: Colors.green,
              //                     colorText:
              //                         Theme.of(context).scaffoldBackgroundColor,
              //                     snackPosition: SnackPosition.TOP,
              //                   );
              //                   Future.delayed(new Duration(seconds: 2))
              //                       .then((value) {
              //                     Get.back();
              //                     Get.back();
              //                     Get.bottomSheet(
              //                       TrainerRatingBottomSheet(
              //                           widget.subscription, false),
              //                     );
              //                   });
              //                 } else {
              //                   Get.snackbar(
              //                     "Failed!",
              //                     "Try again",
              //                     backgroundColor:
              //                         Theme.of(context).primaryColor,
              //                     snackPosition: SnackPosition.TOP,
              //                   );
              //                 }
              //               });
              //             },
              //             style: ButtonStyle(
              //               padding: MaterialStateProperty.all(
              //                 EdgeInsets.symmetric(horizontal: 10.0),
              //               ),
              //               backgroundColor: MaterialStateProperty.all(
              //                   Theme.of(context).primaryColor),
              //               overlayColor: MaterialStateProperty.all(
              //                 Theme.of(context).accentColor.withOpacity(0.3),
              //               ),
              //               shape: MaterialStateProperty.all<
              //                   RoundedRectangleBorder>(
              //                 RoundedRectangleBorder(
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(10.0)),
              //                 ),
              //               ),
              //             ),
              //             child: Text(
              //               "Post review",
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 color: Theme.of(context).scaffoldBackgroundColor,
              //               ),
              //             ),
              //           )
              //         : TextButton(
              //             onPressed: () async {},
              //             style: ButtonStyle(
              //               padding: MaterialStateProperty.all(
              //                 EdgeInsets.symmetric(horizontal: 10.0),
              //               ),
              //               backgroundColor: MaterialStateProperty.all(
              //                   Theme.of(context)
              //                       .primaryColor
              //                       .withOpacity(0.6)),
              //               overlayColor: MaterialStateProperty.all(
              //                 Theme.of(context).accentColor.withOpacity(0.3),
              //               ),
              //               shape: MaterialStateProperty.all<
              //                   RoundedRectangleBorder>(
              //                 RoundedRectangleBorder(
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(10.0)),
              //                 ),
              //               ),
              //             ),
              //             child: Text(
              //               "Post review",
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 color: Theme.of(context).scaffoldBackgroundColor,
              //               ),
              //             ),
              //           );
              //   }),
              // ),
              const SizedBox(height: 15.0),
              Text(
                "Rate ${widget.subscription.trainers.name}",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: RatingBar.builder(
                  minRating: 0.0,
                  maxRating: 5.0,
                  allowHalfRating: false,
                  glowColor: Colors.yellow,
                  itemSize: 40.0,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                      ],
                    );
                  },
                  onRatingUpdate: (rating) {
                    print(rating);
                    givenRating = rating.toInt();
                  },
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());

                    // if there is a review then post a review first
                    // then if rating is greater than 0, post a rating
                    // then at the end unsubscribe
                    // handle unsubscribe also

                    if (reviewController.text.isEmpty && givenRating < 1) {
                      // do simple unsubscribe
                      _con.unsubscribeTrainer(context, widget.subscription);
                    } else if (reviewController.text.isNotEmpty &&
                        givenRating < 1) {
                      // review plus unsub
                      _con
                          .postTrainerReview(
                              context: context,
                              trainerId: widget.subscription.trainers.id,
                              userId: userRepo.currentUser.value.id,
                              review: reviewController.text)
                          .then((value) {
                        if (value) {
                          _con.unsubscribeTrainer(context, widget.subscription);
                        }
                      });
                    } else if (reviewController.text.isEmpty &&
                        givenRating > 0) {
                      // rating plus unsub
                      _con
                          .rateTrainer(
                        context,
                        givenRating,
                        widget.subscription.trainers.id,
                      )
                          .then((value) {
                        if (value) {
                          _con.unsubscribeTrainer(context, widget.subscription);
                        }
                      });
                    } else if (reviewController.text.isNotEmpty &&
                        givenRating > 0) {
                      // rating plus review plus unsub
                      await _con.postTrainerReview(
                          context: context,
                          trainerId: widget.subscription.trainers.id,
                          userId: userRepo.currentUser.value.id,
                          review: reviewController.text);
                      await _con.rateTrainer(context, givenRating,
                          widget.subscription.trainers.id);
                      await _con.unsubscribeTrainer(
                          context, widget.subscription);
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    overlayColor: MaterialStateProperty.all(
                      Theme.of(context).accentColor.withOpacity(0.3),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
