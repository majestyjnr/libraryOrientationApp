import 'package:flutter/material.dart';
import 'package:LibraryOrientationApp/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqHome extends StatefulWidget {
  FaqHome({Key key}) : super(key: key);

  @override
  _FaqHomeState createState() => _FaqHomeState();
}

class _FaqHomeState extends State<FaqHome> {
  bool innerBoxIsScrolled = true;
  String _studentName = '';
  String _studentEmail = '';

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  _getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _studentName = prefs.getString("studentName");
      _studentEmail = prefs.getString("studentEmail");
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 8,
      child: Scaffold(
        backgroundColor: Colors.blue[700],
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                brightness: Brightness.light,
                title: Text(
                  "FAQ's",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      askQuestion(_studentName, _studentEmail);
                    },
                    child: Text('Ask A Question'),
                  )
                ],
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                backgroundColor: Colors.white,
                elevation: 1,
                bottom: TabBar(
                  indicatorColor: Colors.blue,
                  isScrollable: true,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: <Widget>[
                    Tab(
                      text: 'Acquisition',
                    ),
                    Tab(
                      text: 'Circulation',
                    ),
                    Tab(
                      text: 'Info Help Desk',
                    ),
                    Tab(
                      text: 'Lending',
                    ),
                    Tab(
                      text: 'Quick Reference',
                    ),
                    Tab(
                      text: 'Reference',
                    ),
                    Tab(
                      text: 'Security',
                    ),
                    Tab(
                      text: 'Special Reserve',
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              FaqAcquistion(),
              FaqCirculation(),
              FaqInformation(),
              FaqLending(),
              FaqQuick(),
              FaqReference(),
              FaqSecurity(),
              FaqSpecial(),
            ],
          ),
        ),
      ),
    );
  }

  askQuestion(
    String studentName,
    String studentEmail,
  ) {
    Navigator.pushNamed(context, '/AskQuestion', arguments: {
      'studentName': '$studentName',
      'studentEmail': '$studentEmail',
    });
  }
}

// _ask() async {
//   const url =
//       'https://wa.me/+233264337735?text=*Library Enquiry* %0a%0aHi admin, ';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     return SnackBar(
//       content: Text('Cannot launch URL'),
//     );
//   }
// }
