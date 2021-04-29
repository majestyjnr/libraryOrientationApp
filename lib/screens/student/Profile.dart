import 'package:LibraryOrientationApp/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _studentName = '';
  String _studentEmail = '';
  String _studentPhone = '';
  String _studentDepartment = '';
  String _studentLevel = '';

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
      _studentPhone = prefs.getString("studentPhone");
      _studentDepartment = prefs.getString("studentDepartment");
      _studentLevel = prefs.getString("studentLevel");
    });
  }

  _showDialog(BuildContext context) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text('Message'),
      content: Text('Do you really want to logout?'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: Text('Yes'),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.getString('studentLevel');
            prefs.getString('studentName');
            prefs.getString('studentEmail');
            prefs.getString('studentPassword');
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MainAuth(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ],
    );

    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Text(
          'Account',
          style: TextStyle(color: Colors.blue),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.blue),
              onPressed: () {
                _showDialog(context);
              })
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      // Open Edit Profile
                    },
                    title: (_studentName != null)
                        ? Text(_studentName)
                        : Text('Loading...'),
                    subtitle: (_studentName != null)
                        ? Text(_studentEmail)
                        : Text('Loading...'),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Image(
                        image: AssetImage('assets/images/user.png'),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      // Open Edit Profile
                    },
                    title: Row(
                      children: <Widget>[
                        Text('Department:'),
                        Spacer(),
                        Text('ICTE')
                      ],
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Text('Level:'),
                        Spacer(),
                        Text('100'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(20, 8, 20, 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return ChangePassword();
                          //     },
                          //   ),
                          // );
                        },
                        leading: Icon(CupertinoIcons.padlock),
                        title: Text('Change Password'),
                        trailing: Icon(CupertinoIcons.forward),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
