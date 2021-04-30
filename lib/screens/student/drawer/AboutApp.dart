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
                'Library Orientation App\nV 1.0.0',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SelectableText(
              'This is the official Library Orientaion App of UEW',
            ),
          ],
        ),
      ),
    );
  }
}
