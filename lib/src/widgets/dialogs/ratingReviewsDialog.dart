// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import '../../controllers/user_controller.dart';
// import '../../models/subscriptions.dart';
// import 'package:get/get.dart';
// import '../../repositories/user_repo.dart' as userRepo;

// File no longer in use
// See trainerUnsubBottomsheet.dart instead

// class TrainerRatingReviewsDialog extends StatefulWidget {
//   Subscription subscription;
//   TrainerRatingReviewsDialog(this.subscription, {Key key}) : super(key: key);

//   @override
//   _TrainerRatingReviewsDialogState createState() =>
//       _TrainerRatingReviewsDialogState();
// }

// class _TrainerRatingReviewsDialogState
//     extends State<TrainerRatingReviewsDialog> {
//   UserController _con = Get.put(UserController());
//   final TextEditingController reviewController = new TextEditingController();
//   var isReviewEmpty = true.obs;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         height: 250.0,
//         width: 250.0,
//         margin: const EdgeInsets.all(20.0),
//         decoration: const BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(15.0)),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Share your experience with ${widget.subscription.trainers.name}:",
//                 style: TextStyle(
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               TextField(
//                 controller: reviewController,
//                 keyboardType: TextInputType.emailAddress,
//                 maxLines: null,
//                 onChanged: (input) {
//                   if (input.length > 0) {
//                     isReviewEmpty.value = false;
//                   } else {
//                     isReviewEmpty.value = true;
//                   }
//                 },
//                 decoration: InputDecoration(
//                   labelText: "Write a review",
//                   floatingLabelBehavior: FloatingLabelBehavior.never,
//                   labelStyle: TextStyle(
//                     color: Theme.of(context).secondaryHeaderColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15.0,
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5.0, horizontal: 10.0),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                         width: 2.0,
//                         color: Theme.of(context).accentColor.withOpacity(0.2)),
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: Obx(() {
//                   return !isReviewEmpty.value
//                       ? TextButton(
//                           onPressed: () async {
//                             FocusScope.of(context)
//                                 .requestFocus(new FocusNode());
//                             _con
//                                 .postTrainerReview(
//                                     context: context,
//                                     trainerId: widget.subscription.trainers.id,
//                                     userId: userRepo.currentUser.value.id,
//                                     review: reviewController.text)
//                                 .then((value) {
//                               if (value) {
//                                 Get.snackbar(
//                                     "Success!", "Review posted successfully.",
//                                     backgroundColor:
//                                         Theme.of(context).primaryColor);
//                               }
//                             });
//                           },
//                           style: ButtonStyle(
//                             padding: MaterialStateProperty.all(
//                               const EdgeInsets.symmetric(horizontal: 10.0),
//                             ),
//                             backgroundColor: MaterialStateProperty.all(
//                                 Theme.of(context).primaryColor),
//                             overlayColor: MaterialStateProperty.all(
//                               Theme.of(context).accentColor.withOpacity(0.3),
//                             ),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               const RoundedRectangleBorder(
//                                 borderRadius: const BorderRadius.all(
//                                     Radius.circular(10.0)),
//                               ),
//                             ),
//                           ),
//                           child: Text(
//                             "Post review",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                             ),
//                           ),
//                         )
//                       : TextButton(
//                           onPressed: () async {},
//                           style: ButtonStyle(
//                             padding: MaterialStateProperty.all(
//                               const EdgeInsets.symmetric(horizontal: 10.0),
//                             ),
//                             backgroundColor: MaterialStateProperty.all(
//                                 Theme.of(context)
//                                     .primaryColor
//                                     .withOpacity(0.6)),
//                             overlayColor: MaterialStateProperty.all(
//                               Theme.of(context).accentColor.withOpacity(0.3),
//                             ),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               const RoundedRectangleBorder(
//                                 borderRadius: const BorderRadius.all(
//                                     Radius.circular(10.0)),
//                               ),
//                             ),
//                           ),
//                           child: Text(
//                             "Post review",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                             ),
//                           ),
//                         );
//                 }),
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Text(
//                 "Rate ${widget.subscription.trainers.name}",
//                 style: TextStyle(
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               RatingBar.builder(
//                 minRating: 0.0,
//                 maxRating: 5.0,
//                 allowHalfRating: false,
//                 glowColor: Colors.yellow,
//                 itemSize: 30.0,
//                 itemCount: 5,
//                 itemBuilder: (context, index) {
//                   return const Icon(
//                     Icons.star,
//                     color: Colors.yellow,
//                   );
//                 },
//                 onRatingUpdate: (rating) {
//                   print(rating);
//                 },
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: TextButton(
//                   onPressed: () async {},
//                   style: ButtonStyle(
//                     padding: MaterialStateProperty.all(
//                       const EdgeInsets.symmetric(horizontal: 10.0),
//                     ),
//                     backgroundColor: MaterialStateProperty.all(
//                         Theme.of(context).primaryColor),
//                     overlayColor: MaterialStateProperty.all(
//                       Theme.of(context).accentColor.withOpacity(0.3),
//                     ),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     "Done",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).scaffoldBackgroundColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
