import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowCachedNetworkImageWidget extends StatelessWidget {
  final String url;
  final String placeHolderFilePath;
  final double width;
  final double height;
  final BoxFit adjustment;
  final BoxShape shape;
  final Icons errorIcon;
  ShowCachedNetworkImageWidget(this.url, this.placeHolderFilePath,
      {Key key,
      this.width,
      this.height,
      this.adjustment,
      this.errorIcon,
      this.shape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$url",
      placeholder: (context, url) {
        return Container(
          height: height ?? 200.0,
          width: width ?? 150.0,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(5),
            shape: shape ?? BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage("$placeHolderFilePath"),
              fit: adjustment ?? BoxFit.contain,
            ),
          ),
        );
      },
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height ?? 200.0,
          width: width ?? 150.0,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(5),
            shape: shape ?? BoxShape.rectangle,
            image: DecorationImage(
              image: imageProvider,
              fit: adjustment ?? BoxFit.contain,
            ),
          ),
        );
      },
      errorWidget: (context, error, d) {
        print(error.toString());
        print(d.toString());
        return Container(
          height: height ?? 200.0,
          width: width ?? 150.0,
          child: Center(child: Icon(errorIcon ?? Icons.error)),
        );
      },
    );
  }
}
