import 'package:fitness_app/src/helpers/helper.dart';
import 'package:flutter/material.dart';

class PlanCardWidget extends StatelessWidget {
  String name;
  String imgURL;
  String planDuration;
  PlanCardWidget(
      {@required this.name, @required this.imgURL, this.planDuration});
  @override
  Widget build(BuildContext context) {
    print("printing card");
    return Container(
      height: 150.0,
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(imgURL),
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
                  "$name",
                  overflow: TextOverflow.ellipsis,
                  style: Helper.of(context).textStyle(font: FontWeight.bold),
                ),
              ),
            ),
          ),
          planDuration == null
              ? SizedBox()
              : Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      child: Text(
                        "$planDuration",
                        overflow: TextOverflow.ellipsis,
                        style: Helper.of(context).textStyle(
                          font: FontWeight.bold,
                          size: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
