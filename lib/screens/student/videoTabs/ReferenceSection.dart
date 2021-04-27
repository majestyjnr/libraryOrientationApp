import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReferenceSection extends StatefulWidget {
  ReferenceSection({Key key}) : super(key: key);

  @override
  _ReferenceSectionState createState() => _ReferenceSectionState();
}

class _ReferenceSectionState extends State<ReferenceSection> {

  FlickManager flickManager;
  String _videoURL;
  String _videoDescription;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Videos Info')
        .where('videoSection', isEqualTo: 'Reference Section')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          _videoURL = doc['videoURL'];
          _videoDescription = doc['videoDescription'];
        });
        flickManager = FlickManager(
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