import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'About App',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Image(
                    image: AssetImage('assets/images/uew.png'),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'Library Orientation App',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'Build Version: 1.0.0',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SelectableText(
              'This is the official Library Orientaion App of UEW. It enables freshers go through library orientation with ease and to prevent overcrowding at the entrance of the library during orientation. ',
            ),
            SelectableText('With this app students can: '),
            SizedBox(
              height: 5,
            ),
            SelectableText(
                '* Watch Orientation videos from different sections of the library'),
            SizedBox(
              height: 5,
            ),
            SelectableText('* View Frequently ask Questions'),
            SizedBox(
              height: 5,
            ),
            SelectableText('*Ask questions and get and also receive feedback.')
          ],
        ),
      ),
    );
  }
}
