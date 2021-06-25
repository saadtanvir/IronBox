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
  TextEditingController _videoSearchController = new TextEditingController();
  var searchString = "".obs;
  int skip = 0;
  int take = 10;

  void onVideoSelect(YoutubeVideo video) async {
    Get.back(result: video);
  }

  @override
  void initState() {
    // searchString = _videoSearchController.value.text.obs;
    _con.getIronBoxYoutubeVideos(skip, take);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Video",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _videoSearchController,
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                // onSaved: (input) => _con.workoutPlan.muscleType = input,
                // validator: (input) =>
                //     input.length < 1 ? "required" : null,
                onChanged: (input) {
                  searchString.value = input;
                },
                onFieldSubmitted: (input) {
                  print(input);
                  skip = 0;
                  if (input.isNotEmpty) {
                    _con.searchYoutubeVideos(
                        name: input, skip: skip, take: take);
                  }
                },
                decoration: InputDecoration(
                  labelText: Constants.search_video,
                  labelStyle: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                  ),
                  hintText: Constants.enter_video_name,
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).accentColor.withOpacity(0.3),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  suffixIcon: Obx(() {
                    return searchString.value.isEmpty
                        ? IconButton(
                            onPressed: () async {},
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              _videoSearchController.text = "";
                              searchString.value = "";
                              skip = 0;
                              _con.getIronBoxYoutubeVideos(skip, take);
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                  }),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
              // }),
            ),
            SizedBox(
              height: 20.0,
            ),
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
