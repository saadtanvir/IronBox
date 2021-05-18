import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/models/category.dart';
import 'package:fitness_app/src/pages/userPlans.dart';
import 'package:fitness_app/src/widgets/categoryCardWidget.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0 * Constants.appCategories.length.toDouble(),
      width: Helper.of(context).getScreenWidth(),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: Constants.appCategories.length,
        itemBuilder: (context, index) {
          // print("returing card widget");
          return GestureDetector(
            onTap: () {
              Get.to(UserPlans(Constants.appCategoriesName[index],
                  Constants.appCategories[index].name));
            },
            child: CategoryCardWidget(Constants.appCategories[index]),
          );
        },
      ),
    );
  }
}
