import 'package:cached_network_image/cached_network_image.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/category.dart';
import 'package:ironbox/src/models/plan.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class PlanCardWidget extends StatelessWidget {
  Plan plan;
  PlanCardWidget(this.plan);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl:
                "${GlobalConfiguration().get('storage_base_url')}${plan.imgUrl}",
            placeholder: (context, url) {
              return Container(
                height: 150,
                decoration: BoxDecoration(
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
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Text(
                      "${plan.name}",
                      overflow: TextOverflow.ellipsis,
                      style: Helper.of(context).textStyle(
                        font: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                    child: Text(
                      "${plan.duration} days",
                      overflow: TextOverflow.ellipsis,
                      style:
                          Helper.of(context).textStyle(font: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
