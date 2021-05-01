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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                'This is the official Library Orientaion App of UEW. It enables freshers go through library orientation with ease and to prevent overcrowding at the entrance of the library during orientation. ',
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText('With this app, students can: '),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                  '* Watch Orientation videos from different sections of the library'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText('* View Frequently ask Questions'),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                  '* Ask questions and get and also receive feedback.'),
            )
          ],
        ),
      ),
    );
  }
}
