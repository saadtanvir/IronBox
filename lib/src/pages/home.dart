import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/widgets/plansCategoriesWidget.dart';
import 'package:fitness_app/src/widgets/recommendedCarousel.dart';
import 'package:fitness_app/src/widgets/upcomingChallengesCardWidget.dart';
import 'package:fitness_app/src/widgets/userDetailsCardWidget.dart';
import 'package:flutter/material.dart';
import '../helpers/app_constants.dart' as Constants;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: new IconButton(
          icon: new Icon(Icons.notes_rounded,
              color: Theme.of(context).accentColor),
          onPressed: () {
            // open drawer from pages file
            // using parent key
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserDetailsCardWidget(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: UpcomingChallengesWidget(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PlansCategoriesWidget(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: ListTile(
                title: Text(
                  Constants.capitalRecommended,
                  style: Helper.of(context)
                      .textStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            RecommendedCaroousel(),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
