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
  final String parentCategoryId;
  final String name;
  ChildCategoriesList(this.parentCategoryId, this.name, {Key key})
      : super(key: key);

  @override
  _ChildCategoriesListState createState() => _ChildCategoriesListState();
}

class _ChildCategoriesListState extends State<ChildCategoriesList> {
  List<Category> childCategoriesList;
  @override
  void initState() {
    childCategoriesList =
        Helper.getSpecificChildCategories(widget.parentCategoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}"),
      ),
      body: childCategoriesList.length > 0
          ? Container(
              height: 150.0 * childCategoriesList.length.toDouble(),
              width: Helper.of(context).getScreenWidth(),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: childCategoriesList.length,
                itemBuilder: (context, index) {
                  // print("returing card widget");
                  return GestureDetector(
                    onTap: () {},
                    child: SubCategoryListTile(childCategoriesList[index]),
                  );
                },
              ),
            )
          : Center(
              child: Text("No category to show."),
            ),
    );
  }
}
