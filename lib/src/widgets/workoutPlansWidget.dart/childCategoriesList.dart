import 'package:ironbox/src/widgets/workoutPlansWidget.dart/subCategoriesList.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/subCategoryListTile.dart';
import '../../helpers/helper.dart';
import '../../models/category.dart';
import '../../pages/userPlans.dart';
import '../../widgets/categoryCardWidget.dart';
import '../../widgets/userSubscribedTrainers.dart';
import '../../helpers/app_constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChildCategoriesList extends StatefulWidget {
  final Category category;
  ChildCategoriesList(this.category, {Key key}) : super(key: key);

  @override
  _ChildCategoriesListState createState() => _ChildCategoriesListState();
}

class _ChildCategoriesListState extends State<ChildCategoriesList> {
  List<Category> childCategoriesList;

  void onCategoryTap(Category category) {}

  @override
  void initState() {
    childCategoriesList = Helper.getSpecificChildCategories(widget.category.id);
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
              childCategoriesList.length > 0
                  ? SubcategoriesList(childCategoriesList, onCategoryTap)
                  : Center(
                      child: Text("No category to show."),
                    ),
            ],
          ),
        ));
  }
}
