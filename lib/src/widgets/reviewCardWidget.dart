import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/reviews.dart';
import '../widgets/userCircularAatar.dart';

class ReviewCardWidget extends StatelessWidget {
  final Review review;
  const ReviewCardWidget(this.review, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.zero,
        // color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15.0,
                  ),
                  UserCircularAvatar(
                      height: 50.0,
                      width: 60.0,
                      imgUrl: "${review.trainee.avatar}",
                      adjustment: BoxFit.fill),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "${review.trainee.name}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      review.rating != null && review.rating.isNotEmpty
                          ? RatingBar.builder(
                              initialRating: double.parse(review.rating),
                              allowHalfRating: false,
                              ignoreGestures: true,
                              glowColor: Colors.yellow,
                              itemSize: 15.0,
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
                                // print(rating);
                                // givenRating = rating.toInt();
                                // data['rating'] = givenRating.toString();
                              },
                            )
                          : const SizedBox(
                              height: 0.0,
                              width: 0.0,
                            ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "${review.date}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "${review.message}",
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
