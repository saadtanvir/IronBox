import 'package:cached_network_image/cached_network_image.dart';
import 'package:ironbox/src/widgets/showWOPUser/selectWeek.dart';
import '../controllers/plans_controller.dart';
import '../helpers/helper.dart';
import '../models/userWorkoutPlan.dart';
import '../widgets/loadingWidgets/categoriesLoadingWidget.dart';
import '../widgets/playYoutubeVideoWidget.dart';
import '../widgets/reviewCardWidget.dart';
import '../widgets/showTrainerReviews.dart';
import '../widgets/showWOPTrainer/showPlanWeeks.dart';
import '../widgets/workoutPlansWidget.dart/editPlan.dart';
import '../models/workoutPlan.dart';
import '../models/plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import '../repositories/user_repo.dart' as userRepo;
import '../helpers/app_constants.dart' as Constants;

class ShowUserWorkoutPlanDetails extends StatefulWidget {
  final UserWorkoutPlan plan;
  ShowUserWorkoutPlanDetails(this.plan, {Key key}) : super(key: key);

  @override
  _ShowUserWorkoutPlanDetailsState createState() =>
      _ShowUserWorkoutPlanDetailsState();
}

class _ShowUserWorkoutPlanDetailsState
    extends State<ShowUserWorkoutPlanDetails> {
  PlansController _con = Get.put(PlansController());
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
                  // actions: [
                  //   FloatingActionButton(
                  //     onPressed: () {
                  //       // print(Helper.getMainCategoryId("Workout"));
                  //       Get.to(
                  //         EditWorkoutPlan(widget.plan,
                  //             mainCategoryId:
                  //                 Helper.getMainCategoryId("Workout")),
                  //         transition: Transition.rightToLeft,
                  //       );
                  //     },
                  //     child: Icon(
                  //       Icons.edit,
                  //       color: Theme.of(context).scaffoldBackgroundColor,
                  //     ),
                  //     mini: true,
                  //   )
                  // ],
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
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
                        // Row(
                        //   children: [
                        //     Text(
                        //       "${Constants.reviews}:",
                        //       style: TextStyle(
                        //         color: Theme.of(context).primaryColor,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 15.0,
                        //       ),
                        //     ),
                        //     Spacer(),
                        //     TextButton(
                        //       onPressed: () async {
                        //         if (_con.workoutPlanReviews.isNotEmpty) {
                        //           Get.to(
                        //               TrainerReviewsList(_con
                        //                   .workoutPlanReviews.reversed
                        //                   .toList()),
                        //               transition: Transition.rightToLeft);
                        //         }
                        //       },
                        //       child: Text(
                        //         "${Constants.view_all}",
                        //         style: TextStyle(
                        //           color: Theme.of(context).primaryColor,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 15.0,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                        // Obx(() {
                        //   return _con.workoutPlanReviews.isEmpty &&
                        //           !_con.doneFetchingReviews.value
                        //       ? CategoriesLoadingWidget(
                        //           cardCount: 1,
                        //         )
                        //       : _con.workoutPlanReviews.isEmpty &&
                        //               _con.doneFetchingReviews.value
                        //           ? Text(
                        //               "No reviews!",
                        //             )
                        //           : ReviewCardWidget(
                        //               _con.workoutPlanReviews.last);
                        // }),
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
                              // go to details
                              // select weeks
                              // select days
                              Get.to(
                                SelectUserWOPWeek(widget.plan),
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
