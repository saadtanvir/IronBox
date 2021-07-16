import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class UserCircularAvatar extends StatelessWidget {
  final double width;
  final double height;
  final String imgUrl;
  final BoxFit adjustment;
  const UserCircularAvatar(
      {this.height, this.width, @required this.imgUrl, this.adjustment});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) {
        return Container(
          height: height ?? 100.0,
          width: width ?? 100.0,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(5),
            shape: BoxShape.circle,
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
          height: height ?? 100.0,
          width: width ?? 100.0,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(5),
            shape: BoxShape.circle,
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
          height: height ?? 100.0,
          width: width ?? 100.0,
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
    );
  }
}
