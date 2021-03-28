import 'package:fitness_app/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserDetailsCardWidget extends StatefulWidget {
  // it receives user object
  // final User user;
  // initialize in constructor
  @override
  _UserDetailsCardWidgetState createState() => _UserDetailsCardWidgetState();
}

class _UserDetailsCardWidgetState extends State<UserDetailsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: Helper.of(context).getScreenWidth(),
      child: Card(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 2,
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return Container(
                          height: 74,
                          width: 74,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/img/loading.gif"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                      imageUrl:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 74,
                          width: 74,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(5),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Saad",
                          style: Helper.of(context).textStyle(size: 20.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Lahore, Pakistan",
                          overflow: TextOverflow.ellipsis,
                          style: Helper.of(context)
                              .textStyle(size: 18.0, colorOpacity: 0.9),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "Summary",
                  style: Helper.of(context)
                      .textStyle(size: 20.0, font: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    percent: 0.7,
                    startAngle: 85.0,
                    radius: 70.0,
                    lineWidth: 2.0,
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(0.5),
                    progressColor: Constants.scaffoldColor.withOpacity(0.8),
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "1825",
                          style: Helper.of(context)
                              .textStyle(size: 12.0, font: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_walk,
                              size: 10.0,
                              color: Constants.scaffoldColor,
                            ),
                            Text(
                              "STEPS",
                              style: Helper.of(context).textStyle(size: 10.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  CircularPercentIndicator(
                    percent: 0.7,
                    startAngle: 85.0,
                    radius: 70.0,
                    lineWidth: 2.0,
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(0.5),
                    progressColor: Constants.scaffoldColor.withOpacity(0.8),
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "6h 21m",
                          style: Helper.of(context)
                              .textStyle(size: 12.0, font: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.nightlight_round,
                              size: 10.0,
                              color: Constants.scaffoldColor,
                            ),
                            Text(
                              "SLEEP",
                              style: Helper.of(context).textStyle(size: 10.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  CircularPercentIndicator(
                    percent: 0.7,
                    startAngle: 85.0,
                    radius: 70.0,
                    lineWidth: 2.0,
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(0.5),
                    progressColor: Constants.scaffoldColor.withOpacity(0.8),
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "45M",
                          style: Helper.of(context)
                              .textStyle(size: 12.0, font: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fitness_center,
                              size: 10.0,
                              color: Constants.scaffoldColor,
                            ),
                            Text(
                              "WORKOUT",
                              style: Helper.of(context).textStyle(size: 10.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Welcom Saad",
                    style: Helper.of(context)
                        .textStyle(size: 20.0, font: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
