import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/src/helpers/helper.dart';
import 'package:flutter/material.dart';

class RecommendedCardWidget extends StatelessWidget {
  String imgURL;
  String recommendationName;
  RecommendedCardWidget(
      {@required this.imgURL, @required this.recommendationName});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Helper.of(context).getScreenWidth() * 0.40,
      margin: EdgeInsets.only(left: 10.0),
      // color: Colors.brown,
      child: Card(
        // color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10.0,
        child: Stack(
          children: [
            // create whole layout in column
            // then as 2nd child of stack
            // place positioned widgets
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: 150,
                    // width: double.infinity,
                    fit: BoxFit.fill,
                    imageUrl: imgURL,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.fill,
                      // width: double.infinity,
                      height: 150,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  recommendationName,
                ),
              ],
            ),
            Positioned(
              top: 120.0,
              left: 55,
              child: ClipOval(
                child: Material(
                  elevation: 10.0,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.fitness_center_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
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
