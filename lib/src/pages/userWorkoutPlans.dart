import 'package:ironbox/src/widgets/workoutPlansWidget.dart/childCategoriesList.dart';

import '../widgets/workoutPlansWidget.dart/subCategoriesList.dart';
import '../helpers/helper.dart';
import '../models/category.dart';
import '../pages/userPlans.dart';
import '../widgets/categoryCardWidget.dart';
import '../widgets/userSubscribedTrainers.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutPlans extends StatefulWidget {
  final Category category;
  const WorkoutPlans(this.category, {Key key}) : super(key: key);

  @override
  _WorkoutPlansState createState() => _WorkoutPlansState();
}

class _WorkoutPlansState extends State<WorkoutPlans> {
  List<Category> subCategories;

  void onCategoryTap(Category category) {
    Get.to(
      ChildCategoriesList(category),
      transition: Transition.rightToLeft,
    );
  }

  @override
  void initState() {
    // from sub categories list
    // get categories where parent id is workout category id
    subCategories = Helper.getSpecificSubCategories(widget.category.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category.name}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            subCategories.length > 0
                ? SubcategoriesList(subCategories, onCategoryTap)
                : Center(
                    child: Text(
                    "No category to show.",
                  )),
          ],
        ),
      ),
    );
  }
}
