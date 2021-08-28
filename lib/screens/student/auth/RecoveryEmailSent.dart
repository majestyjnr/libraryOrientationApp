import 'package:LibraryOrientationApp/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecoveryEmailSent extends StatefulWidget {
  RecoveryEmailSent({Key key}) : super(key: key);

  @override
  _RecoveryEmailSentState createState() => _RecoveryEmailSentState();
}

class _RecoveryEmailSentState extends State<RecoveryEmailSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) {
                  return MainAuth();
                },
              ), (Route<dynamic> route) => false);
            }),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Recover Password',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              CupertinoIcons.check_mark_circled,
              size: 50,
              color: Colors.blue,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Email Sent. Kindly check your inbox and reset your password',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) {
                      return MainAuth();
                    },
                  ), (Route<dynamic> route) => false);
                },
                child: Text(
                  'Proceed to Login',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
