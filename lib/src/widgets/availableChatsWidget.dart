import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/src/helpers/helper.dart';
import 'package:flutter/material.dart';

class AvailableUserChatsWidget extends StatelessWidget {
  // it will accept img url and username
  // image radius

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, left: 4.0),
      child: Container(
        width: 80.0,
        child: Column(
          children: [
            CachedNetworkImage(
              placeholder: (context, url) {
                return Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/img/loading.gif"),
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
              imageUrl:
                  'https://th.bing.com/th/id/Rcbe9c6caa4f9030112f28aa9df8e33e2?rik=pCI5m%2fgWp8%2fWWw&riu=http%3a%2f%2fwww.lensmen.ie%2fwp-content%2fuploads%2f2015%2f02%2fProfile-Portrait-Photographer-in-Dublin-Ireland..jpg&ehk=Za7WF72x0pY8NyUrVRiYMesP9zQuTivFSKMmlY1CkUg%3d&risl=&pid=ImgRaw',
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Username",
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ],
        ),
      ),
    );
  }
}
