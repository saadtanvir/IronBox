import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/models/category.dart';
import 'package:ironbox/src/widgets/T_createPlanWidget.dart';
import '../../helpers/app_constants.dart' as Constants;

class SelectPlanCategoryDialog extends StatelessWidget {
  final List<Category> appCategories;
  // int categoryIndex = 0;
  var groupValue = 0.obs;
  String categoryId;
  SelectPlanCategoryDialog(this.appCategories, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(appCategories.length);
    return Dialog(
      child: Container(
        height: 300.0,
        width: 250.0,
        margin: EdgeInsets.all(20.0),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(1.0)),
        // ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${Constants.select_category}",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: appCategories.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SizedBox(
                      height: 0.0,
                      width: 0.0,
                    );
                  } else {
                    int radioTileIndex = index;
                    // categoryId = appCategories[index].id;
                    print(radioTileIndex);
                    return Obx(() {
                      return Expanded(
                        flex: 1,
                        child: RadioListTile(
                          value: radioTileIndex,
                          groupValue: groupValue.value,
                          title: Text("${appCategories[index].name}"),
                          activeColor: Theme.of(context).primaryColor,
                          selected:
                              groupValue.value == radioTileIndex ? true : false,
                          onChanged: (val) {
                            print(val);
                            groupValue.value = val;
                            categoryId = appCategories[val].id;
                          },
                        ),
                      );
                    });
                  }
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () async {
                    // go to create plan screen
                    // pass id of main app category
                    print("passing category id: $categoryId");
                    if (categoryId != null) {
                      Get.back();
                      Get.to(
                        TrainerCreatePlanWidget(
                          mainCategoryId: categoryId,
                        ),
                        fullscreenDialog: true,
                      );
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    overlayColor: MaterialStateProperty.all(
                      Theme.of(context).accentColor.withOpacity(0.3),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
