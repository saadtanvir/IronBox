import 'package:fitness_app/src/helpers/helper.dart';
import 'package:fitness_app/src/models/category.dart';
import 'package:flutter/material.dart';

class CategoryCardWidget extends StatelessWidget {
  Category category;
  CategoryCardWidget(this.category);
  @override
  Widget build(BuildContext context) {
    // print("printing card");
    return Container(
      height: 150.0,
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage("${category.backgroundImgUrl}"),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                child: Text(
                  "${category.name}",
                  overflow: TextOverflow.ellipsis,
                  style: Helper.of(context).textStyle(font: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
