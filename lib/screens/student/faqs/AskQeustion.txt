import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papercups_flutter/papercups_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AskQuestion extends StatefulWidget {
  AskQuestion({Key key}) : super(key: key);

  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  String _studentName = '';
  String _studentEmail = '';

  String studentName;
  String studentEmail;

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
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    studentName = arguments['studentName'];
    studentEmail = arguments['studentEmail'];
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
          'Ask A Question',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.account_circle,
              color: Colors.blue,
              size: 37,
            ),
          ),
        ],
      ),
      body: PaperCupsWidget(
        props: Props(
          accountId: "5263542c-c8f2-40f0-a219-193e1ac484f7",
          companyName: 'Library App - Admin',
          title: "Kindly leave us a message",
          subtitle: "We'll send you a reply via your email",
          greeting: "Hi $studentName,",
          customer: CustomerMetadata(
            email: "$studentEmail",
            name: "$studentName",
          ),
        ),
      ),
    );
  }
}
