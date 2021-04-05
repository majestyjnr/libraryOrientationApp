import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         brightness: Brightness.light,
         elevation: 0.5,
         backgroundColor: Colors.white,
         title: Text('Account', style: TextStyle(color: Colors.blue),),
         actions: <Widget>[
           IconButton(icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.blue), onPressed: (){})
         ],
       ),
       body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10,),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      // Open Edit Profile
                    },
                    title: Text('Solomon Aidoo Junior'),
                    subtitle: Text('aidoojuniorsolomon@gmail.com'),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Image(
                        image: AssetImage('assets/images/user.png'),
                      ),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}