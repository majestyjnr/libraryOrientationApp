import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papercups_flutter/papercups_flutter.dart';

class AskQuestion extends StatefulWidget {
  AskQuestion({Key key}) : super(key: key);

  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
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
          accountId: "d742419b-0722-40e3-9187-772d4a806824",
          companyName: 'Library App - Admin',
          title: 'Kindly leave us a message',
          subtitle: "We'll send you a reply via your email",
          customer: CustomerMetadata(
              email: 'developermajesty@gmail.com',
              name: 'Solomon Aidoo Junior'),
        ),
      ),
    );
  }
}
