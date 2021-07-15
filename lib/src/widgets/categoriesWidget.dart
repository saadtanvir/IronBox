import '../pages/userWorkoutPlans.dart';
import '../helpers/helper.dart';
import '../models/category.dart';
import '../widgets/categoryCardWidget.dart';
import '../widgets/userSubscribedTrainers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesWidget extends StatelessWidget {
  final List<Category> appCategories;
  CategoriesWidget(this.appCategories);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0 * appCategories.length.toDouble(),
      width: Helper.of(context).getScreenWidth(),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: appCategories.length,
        itemBuilder: (context, index) {
          // print("returing card widget");
          return GestureDetector(
            onTap: () {
              print(appCategories[index].name);
              switch (appCategories[index].name) {
                case "Trainers":
                  {
                    // go to subscribed trainers page
                    Get.to(SubscribedTrainers());
                  }
                  break;
                case "Workout":
                  {
                    // go to user workout plans
                    Get.to(UserAllWorkoutPlans());
                  }
                  break;
                case "Diet":
                  {
                    // go to diet plans
                  }
                  break;
              }
            },
            child: CategoryCardWidget(appCategories[index]),
          );
        },
      ),
    );
  }
}
