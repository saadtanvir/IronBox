import '../../helpers/helper.dart';
import 'package:flutter/material.dart';

class CategoriesLoadingWidget extends StatelessWidget {
  final int cardCount;
  const CategoriesLoadingWidget({Key key, this.cardCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cardCount ?? 2,
      itemBuilder: (context, index) {
        return Container(
          height: 150.0,
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Stack(
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  image: const DecorationImage(
                    image: const AssetImage("assets/img/loading.gif"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 10.0,
                // left: 10.0,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: const Text(
                      "",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
