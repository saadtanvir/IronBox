import 'dart:convert';
import 'dart:io';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:http/http.dart' as http;
import 'package:ironbox/src/models/youtubeVideo.dart';

Future<Stream<YoutubeVideo>> getIronBoxVideos(int skip, int take) async {
  Uri uri = Helper.getUri('video_library/skip=$skip/take=$take');
  print("URI For Getting IronBox Videos: ${uri.toString()}");
  try {
    final client = new http.Client();
    // client.po
    final streamedRest = await client.send(http.Request('get', uri));

    // print(streamedRest.stream.map((data) {
    //   print(data);
    // }));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          print(data);
          return Helper.getData(data);
        })
        .expand((data) => (data as List))
        .map((data) {
          print("printing videos data");
          print(data);
          return YoutubeVideo.fromJSON(data);
        });
  } on SocketException {
    print("Plan Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Video Repo Error: $e");
    return new Stream.value(new YoutubeVideo.fromJSON({}));
  }
}
