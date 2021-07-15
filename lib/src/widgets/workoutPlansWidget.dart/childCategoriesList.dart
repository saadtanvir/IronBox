import 'package:ironbox/src/widgets/workoutPlansWidget.dart/subCategoriesList.dart';
import '../../helpers/helper.dart';
import '../../models/category.dart';
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
                  : const Center(
                      child: const Text("No category to show."),
                    ),
            ],
          ),
        ));
  }
}
