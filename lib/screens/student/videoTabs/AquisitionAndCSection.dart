import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AcquisitionSection extends StatefulWidget {
  AcquisitionSection({Key key}) : super(key: key);

  @override
  _AcquisitionSectionState createState() => _AcquisitionSectionState();
}

class _AcquisitionSectionState extends State<AcquisitionSection> {
  FlickManager flickManager;
  var _videoURL;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Videos Info')
        .where('videoSection', isEqualTo: 'Acquisition Section')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          _videoURL = doc['videoURL'];
        });
      });
    });

    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(_videoURL),
    );
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
              ? FlickVideoPlayer(
                  flickManager: flickManager,
                )
              : Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                  ),
                ),
        ],
      ),
    );
  }
}
