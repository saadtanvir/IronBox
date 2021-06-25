import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/youtube_video_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/category.dart';
import 'package:ironbox/src/models/youtubeVideo.dart';
import 'package:ironbox/src/widgets/listTileWidgets/customYoutubeListTile.dart';
import '../helpers/app_constants.dart' as Constants;

class YoutubeVideosListWidget extends StatelessWidget {
  final List<YoutubeVideo> youtubeVideosList;
  final Function onVideoSelect;
  YoutubeVideosListWidget(this.youtubeVideosList, this.onVideoSelect, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      height: 90 * youtubeVideosList.length.toDouble(),
      child: ListView.builder(
        itemCount: youtubeVideosList.length,
        // shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onVideoSelect(youtubeVideosList[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomYoutubeListTileWidget(youtubeVideosList[index]),
            ),
          );
        },
      ),
    );
  }
}
