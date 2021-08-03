import 'package:ironbox/src/widgets/dialogs/addWOPReviewDialog.dart';
import 'package:ironbox/src/widgets/reviewsList.dart';
import '../models/reviews.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;

class ShowReviews extends StatefulWidget {
  final List<Review> reviews;
  final String appBarTitle;
  final Function onReviewTap;
  final Function addReview;
  final bool canAddReview;
  ShowReviews(
      {Key key,
      this.appBarTitle,
      this.addReview,
      @required this.canAddReview,
      @required this.onReviewTap,
      @required this.reviews})
      : super(key: key);

  @override
  _ShowReviewsState createState() => _ShowReviewsState();
}

class _ShowReviewsState extends State<ShowReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.appBarTitle ?? 'Reviews'}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.reviews.isNotEmpty
                ? ReviewsList(widget.reviews, widget.onReviewTap)
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: const Text("No reviews!"),
                    ),
                  ),
            const SizedBox(
              height: 50.0,
            ),
            !widget.canAddReview
                ? const SizedBox(
                    height: 0.0,
                    width: 0.0,
                  )
                : TextButton(
                    onPressed: () async {
                      // show custom dialog
                      // to take rating and review
                      var data = await Get.dialog(
                        AddWOPReviewDialog(),
                      );
                      widget.addReview(data);
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      overlayColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor.withOpacity(0.3),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    child: Text(
                      Constants.addReview,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
