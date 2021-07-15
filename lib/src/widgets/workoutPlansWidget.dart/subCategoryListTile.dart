import '../../models/category.dart';
import 'package:flutter/material.dart';

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
