import 'package:cached_network_image/cached_network_image.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class CategoryCardWidget extends StatelessWidget {
  Category category;
  CategoryCardWidget(this.category);
  @override
  Widget build(BuildContext context) {
    // print("printing card");
    return Container(
      height: 150.0,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: "${category.backgroundImgUrl}",
            placeholder: (context, url) {
              return Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                    image: AssetImage("assets/img/loading.gif"),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 10.0,
            // left: 10.0,
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
