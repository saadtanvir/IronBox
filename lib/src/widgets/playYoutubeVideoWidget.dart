import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayYoutubeVideoWidget extends StatefulWidget {
  String url;
  // final double height;
  final double width;
  PlayYoutubeVideoWidget(this.url, {this.width});
  @override
  _PlayYoutubeVideoWidgetState createState() => _PlayYoutubeVideoWidgetState();
}

class _PlayYoutubeVideoWidgetState extends State<PlayYoutubeVideoWidget> {
  YoutubePlayerController _youtubePlayerController;
  String videoId;

  @override
  void initState() {
    videoId = YoutubePlayer.convertUrlToId(widget.url);
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubePlayerController,
          width: widget.width ?? double.infinity,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Theme.of(context).primaryColor,
          progressColors: ProgressBarColors(
            playedColor: Theme.of(context).primaryColor,
            handleColor: Theme.of(context).primaryColor,
            bufferedColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          bufferIndicator: CircularProgressIndicator(),
        ),
        builder: (context, player) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              videoId != null
                  ? player
                  : Container(
                      height: 200.0,
                      width: double.infinity,
                      color: Colors.grey[500],
                      child: Icon(Icons.error),
                    ),
              SizedBox(
                height: 5.0,
              ),
            ],
          );
        });
  }
}
