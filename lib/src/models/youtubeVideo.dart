class YoutubeVideo {
  String id;
  String name;
  String description;
  String status;
  String link;

  YoutubeVideo();

  YoutubeVideo.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      name = jsonMap['name'] != null ? jsonMap['name'] : "";
      description =
          jsonMap['description'] != null ? jsonMap['description'] : "";
      status = jsonMap['status'] != null ? jsonMap['status'] : "";
      link = jsonMap['link'] != null ? jsonMap['link'] : "";
    } catch (e) {
      print("Youtube Video Model Error: $e");
    }
  }
}
