import 'package:cached_network_image/cached_network_image.dart';
import 'package:ironbox/src/models/reviews.dart';
import 'package:ironbox/src/widgets/showReviews.dart';
import '../../controllers/plans_controller.dart';
import '../../helpers/helper.dart';
import '../../widgets/loadingWidgets/categoriesLoadingWidget.dart';
import '../../widgets/reviewCardWidget.dart';
import '../reviewsList.dart';
import '../../widgets/showWOPTrainer/showPlanWeeks.dart';
import '../../widgets/workoutPlansWidget.dart/editPlan.dart';
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
  PlansController _con = Get.put(PlansController());

  void onReviewTap(Review review) {
    // calls when review tap
  }

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
                actions: [
                  FloatingActionButton(
                    onPressed: () {
                      // print(Helper.getMainCategoryId("Workout"));
                      Get.to(
                        EditWorkoutPlan(widget.plan,
                            mainCategoryId:
                                Helper.getMainCategoryId("Workout")),
                        transition: Transition.rightToLeft,
                      );
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
                    Text("${widget.plan.description}"),
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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            "${Constants.reviews}:",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextButton(
                            onPressed: () async {
                              if (_con.workoutPlanReviews.isNotEmpty) {
                                Get.to(
                                  ShowReviews(
                                    reviews: _con.workoutPlanReviews.reversed
                                        .toList(),
                                    onReviewTap: onReviewTap,
                                    canAddReview: false,
                                  ),
                                  transition: Transition.rightToLeft,
                                );
                              }
                            },
                            child: Text(
                              "${Constants.view_all}",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
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
                              ? const Text(
                                  "No reviews!",
                                )
                              : ReviewCardWidget(_con.workoutPlanReviews.last);
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
                          Get.to(
                            ShowPlanWeeksList(widget.plan),
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
            ],
          ),
        ],
      ),
    );
  }
}
