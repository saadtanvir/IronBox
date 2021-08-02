import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class AddWOPReviewDialog extends StatelessWidget {
  int givenRating = 1;
  TextEditingController reviewController = new TextEditingController();
  Map<String, String> data = {};
  AddWOPReviewDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10.0,
      child: Container(
        width: 200,
        height: 200,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Rate",
                  style: TextStyle(
                    fontSize: 20.0,
                    // fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                RatingBar.builder(
                  initialRating: 1.0,
                  minRating: 1.0,
                  maxRating: 5.0,
                  allowHalfRating: false,
                  glowColor: Colors.yellow,
                  itemSize: 35.0,
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
                    data['rating'] = givenRating.toString();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              height: 5.0,
              thickness: 2.0,
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                border: InputBorder.none,
                // border: OutlineInputBorder(
                //   borderSide: BorderSide(
                //       width: 2.0,
                //       color: Theme.of(context).accentColor.withOpacity(0.2)),
                //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                // ),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 40.0,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: TextButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  data['message'] = reviewController.text;
                  data['rating'] = givenRating.toString();
                  Get.back(result: data);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.zero,
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  overlayColor: MaterialStateProperty.all(
                    Theme.of(context).accentColor.withOpacity(0.3),
                  ),
                  // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //   const RoundedRectangleBorder(
                  //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  //   ),
                  // ),
                ),
                child: Text(
                  "Post Review",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
