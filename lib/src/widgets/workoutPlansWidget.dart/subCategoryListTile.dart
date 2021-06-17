import '../../helpers/helper.dart';
import '../../models/category.dart';
import '../../pages/userPlans.dart';
import '../../widgets/categoryCardWidget.dart';
import '../../widgets/userSubscribedTrainers.dart';
import '../../helpers/app_constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryListTile extends StatelessWidget {
  Category category;
  SubCategoryListTile(this.category, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "${category.name}",
      ),
    );
  }
}
