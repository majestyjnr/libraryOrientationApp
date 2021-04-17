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
  FlickManager flickManager = FlickManager(
    videoPlayerController: VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/libraryorientationapp.appspot.com/o/videos%2F2fa6f440-9ed7-11eb-86c6-7928581c3d51?alt=media&token=8954fabf-71fd-4efa-80b2-3eba2b6a0f50'),
  );
  var _videoURL;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Videos Info')
        // .where('videoSection', isEqualTo: 'Acquisition Section')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        print(doc);

        setState(() {
          _videoURL = doc['videoURL'];
        });
        print(_videoURL);
        print('done');
      });
    });
    print('done');
  }

  // @override
  // void dispose() {
  //   flickManager.dispose();
  //   super.dispose();
  // }

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
