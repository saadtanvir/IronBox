import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class ImageDialogWidget extends StatelessWidget {
  final double height;
  final double width;
  final String imgUrl;
  const ImageDialogWidget(this.imgUrl, {Key key, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).primaryColor,
      child: CachedNetworkImage(
        placeholder: (context, url) {
          return Container(
            height: height ?? 300,
            width: width ?? 150,
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(5),
              // shape: BoxShape.circle,
              image: const DecorationImage(
                image: const AssetImage("assets/img/loading.gif"),
                fit: BoxFit.contain,
              ),
            ),
          );
        },
        imageUrl: '${GlobalConfiguration().get('storage_base_url')}$imgUrl',
        imageBuilder: (context, imageProvider) {
          return Container(
            height: height ?? 300,
            width: width ?? 150,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(5),
              // shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          );
        },
        errorWidget: (context, error, d) {
          print(error.toString());
          print(d.toString());
          return Container(
            height: height ?? 100,
            width: width ?? 80,
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(5),
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: const AssetImage("assets/img/profile_placeholder.png"),
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
