import 'package:LibraryOrientationApp/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainAuth extends StatefulWidget {
  MainAuth({Key key}) : super(key: key);

  @override
  _MainAuthState createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
              Container(
                height: 550,
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      brightness: Brightness.light,
                      centerTitle: true,
                      title: Text(
                        'Library Orientaion App',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      bottom: TabBar(
                        indicatorColor: Colors.blue,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: <Widget>[
                          Tab(
                            text: 'SIGNIN',
                          ),
                          Tab(
                            text: 'SIGNUP',
                          ),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        Signin(),
                        Signup(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
