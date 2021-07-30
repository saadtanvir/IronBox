import 'package:cached_network_image/cached_network_image.dart';
import 'package:ironbox/src/widgets/loadingWidgets/categoriesLoadingWidget.dart';
import 'package:ironbox/src/widgets/reviewCardWidget.dart';
import '../widgets/showWOPUser/selectWeek.dart';
import '../controllers/plans_controller.dart';
import '../models/userWorkoutPlan.dart';
import '../widgets/playYoutubeVideoWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import '../helpers/app_constants.dart' as Constants;

// full details when user has already bought the plan

class ShowUserWorkoutPlanDetails extends StatefulWidget {
  final UserWorkoutPlan plan;
  ShowUserWorkoutPlanDetails(this.plan, {Key key}) : super(key: key);

  @override
  _ShowUserWorkoutPlanDetailsState createState() =>
      _ShowUserWorkoutPlanDetailsState();
}

class _ShowUserWorkoutPlanDetailsState
    extends State<ShowUserWorkoutPlanDetails> {
  PlansController _con =
      Get.put(PlansController(), tag: Constants.userWOPDetailsController);

  @override
  void initState() {
    _con.getWOPReviews(widget.plan.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomScrollView(
            primary: true,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                expandedHeight: 250,
                elevation: 0,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
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
                    placeholder: (context, url) {
                      return const Image(
                        image: const AssetImage("assets/img/loading.gif"),
                        fit: BoxFit.cover,
                      );
                    },
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
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
                            const SizedBox(
                              height: 5.0,
                            ),
                            widget.plan.difficultyLevel == 1
                                ? const Text("Easy")
                                : widget.plan.difficultyLevel == 2
                                    ? const Text("Intermediate")
                                    : const Text("Hard"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${Constants.description}:",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                          "${widget.plan.description} description it is just to test the UI and stuff you know so yeah duhh"),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "${Constants.caution}:",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text("${widget.plan.caution}"),
                      const SizedBox(
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
                      Row(
                        children: [
                          const Text(
                            "Reviews",
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "View All",
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Obx(() {
                        return _con.workoutPlanReviews.isEmpty &&
                                !_con.doneFetchingReviews.value
                            ? CategoriesLoadingWidget(
                                cardCount: 1,
                              )
                            : _con.workoutPlanReviews.isEmpty &&
                                    _con.doneFetchingReviews.value
                                ? Text(
                                    "No reviews!",
                                  )
                                : ReviewCardWidget(
                                    _con.workoutPlanReviews.last);
                      }),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: PlayYoutubeVideoWidget(widget.plan.videoUrl),
                      ),
                      const SizedBox(
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
                              const EdgeInsets.symmetric(horizontal: 30.0),
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
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
