import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/youtube_video_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/category.dart';
import 'package:ironbox/src/models/youtubeVideo.dart';
import 'package:ironbox/src/widgets/loadingWidgets/showCachedNetworkImage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../helpers/app_constants.dart' as Constants;

class CustomYoutubeListTileWidget extends StatefulWidget {
  final YoutubeVideo youtubeVideo;
  CustomYoutubeListTileWidget(this.youtubeVideo, {Key key}) : super(key: key);

  @override
  _CustomYoutubeListTileWidgetState createState() =>
      _CustomYoutubeListTileWidgetState();
}

class _CustomYoutubeListTileWidgetState
    extends State<CustomYoutubeListTileWidget> {
  String videoId = "";
  String videoThumbnailUrl = "";

  @override
  void initState() {
    print("video link: ${widget.youtubeVideo.link}");
    videoId = YoutubePlayer.convertUrlToId(widget.youtubeVideo.link);
    videoThumbnailUrl = Helper.getYoutubeVideoThumbnailUrl(videoId: videoId);
    print("thumbnail: $videoThumbnailUrl");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ShowCachedNetworkImageWidget(
              videoThumbnailUrl,
              "assets/img/loading.gif",
              height: 65.0,
              width: 65.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${widget.youtubeVideo.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
