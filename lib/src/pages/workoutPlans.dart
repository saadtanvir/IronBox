import 'package:ironbox/src/widgets/workoutPlansWidget.dart/subCategoriesList.dart';

import '../helpers/helper.dart';
import '../models/category.dart';
import '../pages/userPlans.dart';
import '../widgets/categoryCardWidget.dart';
import '../widgets/userSubscribedTrainers.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutPlans extends StatefulWidget {
  final String workoutCategoryId;
  final String name;
  const WorkoutPlans(this.workoutCategoryId, this.name, {Key key})
      : super(key: key);

  @override
  _WorkoutPlansState createState() => _WorkoutPlansState();
}

class _WorkoutPlansState extends State<WorkoutPlans> {
  List<Category> subCategories;
  @override
  void initState() {
    // from sub categories list
    // get categories where parent id is workout category id
    subCategories = Helper.getSpecificSubCategories(widget.workoutCategoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            subCategories.length > 0
                ? SubcategoriesList(subCategories)
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
