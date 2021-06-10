import 'package:ironbox/src/widgets/reviewCardWidget.dart';

import '../helpers/helper.dart';
import '../models/reviews.dart';
import 'package:flutter/material.dart';

class TrainerReviewsList extends StatefulWidget {
  final List<Review> reviews;
  const TrainerReviewsList(this.reviews, {Key key}) : super(key: key);

  @override
  _TrainerReviewsListState createState() => _TrainerReviewsListState();
}

class _TrainerReviewsListState extends State<TrainerReviewsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews"),
      ),
      body: Container(
        height: 160.0 * widget.reviews.length.toDouble(),
        width: Helper.of(context).getScreenWidth(),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.reviews.length,
          itemBuilder: (context, index) {
            // print("returing card widget");
            return GestureDetector(
              onTap: () {},
              child: ReviewCardWidget(widget.reviews[index]),
            );
          },
        ),
      ),
    );
  }
}
