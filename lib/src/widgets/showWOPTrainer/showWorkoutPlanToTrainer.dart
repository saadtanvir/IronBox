import 'package:cached_network_image/cached_network_image.dart';
import 'package:ironbox/src/widgets/showWOPTrainer/showPlanWeeks.dart';
import '../../models/workoutPlan.dart';
import '../../models/plan.dart';
import '../T_editPlanWidget.dart';
import '../playYoutubeVideoWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import '../../repositories/user_repo.dart' as userRepo;
import '../../helpers/app_constants.dart' as Constants;

class ShowWorkoutPlanToTrainer extends StatefulWidget {
  final WorkoutPlan plan;
  ShowWorkoutPlanToTrainer(this.plan, {Key key}) : super(key: key);

  @override
  _ShowWorkoutPlanToTrainerState createState() =>
      _ShowWorkoutPlanToTrainerState();
}

class _ShowWorkoutPlanToTrainerState extends State<ShowWorkoutPlanToTrainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: CustomScrollView(
              primary: true,
              shrinkWrap: false,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.9),
                  expandedHeight: 250,
                  elevation: 0,
                  iconTheme:
                      IconThemeData(color: Theme.of(context).primaryColor),
                  actions: [
                    FloatingActionButton(
                      onPressed: () {
                        // Get.to(TrainerEditPlanWidget(widget.plan));
                      },
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      mini: true,
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl:
                          "${GlobalConfiguration().get('storage_base_url')}${widget.plan.coverImg}",
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      ListTile(
                        isThreeLine: true,
                        title: Text(
                          "${widget.plan.title}",
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          "${widget.plan.muscleType}\n${widget.plan.durationInWeeks} Weeks",
                        ),
                        trailing: Column(
                          children: [
                            Text("\$${widget.plan.price}"),
                            SizedBox(
                              height: 5.0,
                            ),
                            widget.plan.difficultyLevel == 1
                                ? Text("Easy")
                                : widget.plan.difficultyLevel == 2
                                    ? Text("Intermediate")
                                    : Text("Hard"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${Constants.description}:",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                          "${widget.plan.description} description it is just to test the UI and stuff you know so yeah duhh"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${Constants.caution}:",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("${widget.plan.caution}"),
                      SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: PlayYoutubeVideoWidget(widget.plan.videoUrl),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () async {
                            Get.to(
                              ShowPlanWeeksList(widget.plan),
                              transition: Transition.rightToLeft,
                            );
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 30.0),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            overlayColor: MaterialStateProperty.all(
                              Theme.of(context).accentColor.withOpacity(0.3),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                          ),
                          child: Text(
                            Constants.detail,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
