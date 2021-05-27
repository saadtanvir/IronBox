import 'package:cached_network_image/cached_network_image.dart';
import 'package:ironbox/src/widgets/lastMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CachedNetworkImage(
          placeholder: (context, url) {
            return Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(5),
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
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        title: Text("Firebase"),
        subtitle: LastMessageWidget(),
        trailing: Text("15:23"),
      ),
    );
  }
}
