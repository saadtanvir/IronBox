import 'package:ironbox/src/widgets/workoutPlansWidget.dart/childCategoriesList.dart';
import 'package:ironbox/src/widgets/workoutPlansWidget.dart/subCategoryListTile.dart';
import '../../helpers/helper.dart';
import '../../models/category.dart';
import '../../pages/userPlans.dart';
import '../../widgets/categoryCardWidget.dart';
import '../../widgets/userSubscribedTrainers.dart';
import '../../helpers/app_constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubcategoriesList extends StatelessWidget {
  // receives a list of sub categories
  List<Category> categories;
  final Function onCategoryTap;
  SubcategoriesList(this.categories, this.onCategoryTap, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0 * categories.length.toDouble(),
      width: Helper.of(context).getScreenWidth(),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          // print("returing card widget");
          return GestureDetector(
            onTap: () {
              // go to child categories
              // by passing category

              onCategoryTap(categories[index]);
            },
            child: SubCategoryListTile(categories[index]),
          );
        },
      ),
    );
  }
}
