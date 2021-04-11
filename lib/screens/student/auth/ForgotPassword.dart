import 'package:LibraryOrientationApp/screens/student/auth/RecoveryEmailSent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:toast/toast.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isLoading = false;
  TextEditingController _emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Recover Password',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Text(
                "Enter your email address associated with this app. We'll send you an email to enable you reset your password.",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 1.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.mail),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailController.text)
                          .then(
                            (value) => Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                              builder: (context) {
                                return RecoveryEmailSent();
                              },
                            ), (Route<dynamic> route) => false),
                          );
                    } catch (e) {
                      Toast.show(
                        '$e',
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM,
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: isLoading
                      ? NutsActivityIndicator(
                          activeColor: Colors.white,
                        )
                      : Text(
                          'Submit',
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
      ),
    );
  }
}
