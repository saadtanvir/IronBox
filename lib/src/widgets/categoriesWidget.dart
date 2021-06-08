import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/category.dart';
import 'package:ironbox/src/pages/userPlans.dart';
import 'package:ironbox/src/widgets/categoryCardWidget.dart';
import 'package:ironbox/src/widgets/userSubscribedTrainers.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesWidget extends StatelessWidget {
  List<Category> categories;
  CategoriesWidget(this.categories);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0 * categories.length.toDouble(),
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
              print(categories[index].name);
              switch (categories[index].name) {
                case "Trainers":
                  {
                    // go to subscribed trainers page
                    Get.to(SubscribedTrainers());
                  }
                  break;
                case "Workout":
                  {
                    // go to workout plans
                  }
                  break;
                case "Diet":
                  {
                    // go to diet plans
                  }
                  break;
              }
            },
            child: CategoryCardWidget(categories[index]),
          );
        },
      ),
    );
  }
}
