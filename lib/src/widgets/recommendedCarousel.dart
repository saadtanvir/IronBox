import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/widgets/recommededCardWidget.dart';
import 'package:flutter/material.dart';

class RecommendedCaroousel extends StatefulWidget {
  @override
  _RecommendedCaroouselState createState() => _RecommendedCaroouselState();
}

class _RecommendedCaroouselState extends State<RecommendedCaroousel> {
  List<String> recommendedPlansImages = [
    "https://media.istockphoto.com/photos/young-fitness-woman-runner-running-on-sunrise-seaside-trail-picture-id604370074?k=6&m=604370074&s=170667a&w=0&h=HqNaMZesNp987u4Mp-yQRxfJzyh3cyHca4QaWsqNpEg=",
    "https://th.bing.com/th/id/Re2bf720cacd12c560765ff20d0a0bfa5?rik=qR18EYinLMh8CA&pid=ImgRaw",
    "https://www.mountaineers.org/locations-lodges/seattle-branch/committees/seattle-hiking-backpacking/seattle-hiking-committee/course-templates/conditioning-hiking-series/conditioning-hiking-series-seattle-2018/@@images/image",
    "https://th.bing.com/th/id/R6d50365ffbde4dd4e7c1848b342b7610?rik=oTjaGr5Qc2C4pg&riu=http%3a%2f%2fcdn1.theinertia.com%2fwp-content%2fuploads%2f2016%2f04%2fsurf-1.jpg&ehk=fXmJoXzqc%2fBh65qRHf%2btfJ9L5xMlHtPXEBBq7isKVsY%3d&risl=&pid=ImgRaw"
  ];

  List<String> recommendationName = ["Training", "Workout", "Diet", "Workout"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.0,
      width: Helper.of(context).getScreenWidth(),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: recommendedPlansImages.length,
        itemBuilder: (context, index) {
          print("returing carousel");
          return GestureDetector(
            onTap: () {},
            child: RecommendedCardWidget(
                recommendationName: recommendationName[index],
                imgURL: recommendedPlansImages[index]),
          );
        },
      ),
    );
  }
}
