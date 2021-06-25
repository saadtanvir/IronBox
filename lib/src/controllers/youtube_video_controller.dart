import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/youtubeVideo.dart';
import '../repositories/video_repo.dart' as videoRepo;

class YoutubeVideoController extends GetxController {
  List<YoutubeVideo> youtubeVideos = List<YoutubeVideo>().obs;
  var doneFetchingVideos = false.obs;

  void getIronBoxYoutubeVideos(int skip, int take) async {
    doneFetchingVideos.value = false;
    youtubeVideos.clear();
    final Stream<YoutubeVideo> stream =
        await videoRepo.getIronBoxVideos(skip, take);

    stream.listen(
      (YoutubeVideo _video) {
        youtubeVideos.add(_video);
      },
      onError: (e) {
        print("Youtube videos Controller Error: $e");
      },
      onDone: () {
        print("done fetching videos");
        doneFetchingVideos.value = true;
      },
    );
  }

  void searchYoutubeVideos(
      {@required String name, @required int skip, @required int take}) async {
    doneFetchingVideos.value = false;
    youtubeVideos.clear();
    final Stream<YoutubeVideo> stream =
        await videoRepo.searchYoutubeVideo(name: name, skip: skip, take: take);

    stream.listen((YoutubeVideo _video) {
      youtubeVideos.add(_video);
    }, onError: (e) {
      print("Youtube videos Controller Error: $e");
    }, onDone: () {
      print("done fetching videos");
      doneFetchingVideos.value = true;
    });
  }
}
