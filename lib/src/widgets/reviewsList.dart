import 'package:ironbox/src/widgets/reviewCardWidget.dart';
import '../helpers/helper.dart';
import '../models/reviews.dart';
import 'package:flutter/material.dart';

class ReviewsList extends StatelessWidget {
  final List<Review> reviews;
  final Function onReviewTap;
  const ReviewsList(
    this.reviews,
    this.onReviewTap, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0 * reviews.length.toDouble(),
      width: Helper.of(context).getScreenWidth(),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          // print("returing card widget");
          return GestureDetector(
            onTap: () {
              onReviewTap(reviews[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ReviewCardWidget(reviews[index]),
            ),
          );
        },
      ),
    );
  }
}
