import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CirculationSection extends StatefulWidget {
  CirculationSection({Key key}) : super(key: key);

  @override
  _CirculationSectionState createState() => _CirculationSectionState();
}

class _CirculationSectionState extends State<CirculationSection> {
   FlickManager flickManager;
  String _videoURL;
  String _videoDescription;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Videos Info')
        .where('videoSection', isEqualTo: 'Circulation Section')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          _videoURL = doc['videoURL'];
          _videoDescription = doc['videoDescription'];
        });
        flickManager = FlickManager(
          autoPlay: false,
          videoPlayerController: VideoPlayerController.network('$_videoURL'),
        );
      });
    });
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (_videoURL != null)
              ? Container(
                  child: FlickVideoPlayer(
                    flickManager: flickManager,
                    flickVideoWithControls: FlickVideoWithControls(
                      controls: FlickPortraitControls(),
                    ),
                    flickVideoWithControlsFullscreen: FlickVideoWithControls(
                      controls: FlickLandscapeControls(),
                    ),
                  ),
                )
              : Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 0,
          ),
          SizedBox(
            height: 20,
          ),
          (_videoDescription != null)
              ? Text(
                  _videoDescription,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}