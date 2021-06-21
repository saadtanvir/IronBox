import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/controllers/youtube_video_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/category.dart';
import 'package:ironbox/src/models/youtubeVideo.dart';
import 'package:ironbox/src/widgets/youtubeVideosListWidget.dart';
import '../helpers/app_constants.dart' as Constants;

class VideoLib extends StatefulWidget {
  const VideoLib({Key key}) : super(key: key);

  @override
  _VideoLibState createState() => _VideoLibState();
}

class _VideoLibState extends State<VideoLib> {
  YoutubeVideoController _con = Get.put(YoutubeVideoController());
  int skip = 0;
  int take = 10;

  void onVideoSelect(YoutubeVideo video) async {
    Get.back(result: video);
  }

  @override
  void initState() {
    _con.getIronBoxYoutubeVideos(skip, take);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return _con.youtubeVideos.isEmpty &&
                      !_con.doneFetchingVideos.value
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : _con.youtubeVideos.isEmpty && _con.doneFetchingVideos.value
                      ? Center(
                          child: Text("No videos to show!"),
                        )
                      : YoutubeVideosListWidget(
                          _con.youtubeVideos, onVideoSelect);
            }),
          ],
        ),
      ),
    );
  }
}
