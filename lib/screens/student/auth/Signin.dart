import 'package:LibraryOrientationApp/main.dart';
import 'package:LibraryOrientationApp/screens/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:toast/toast.dart';

class Signin extends StatefulWidget {
  Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool obscured = true;
  bool isLoading = false;
  bool _emailValidate = false;
  bool _passwordValidate = false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  _showDialog(BuildContext context) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text('Error'),
      content: Text('Invalid Email or Password'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Try Again'),
          onPressed: () {
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 1.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _emailValidate = false;
                        });
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                        RegExp('[ ]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.mail),
                      errorText:
                          _emailValidate ? 'Email field cannot be empty' : null,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 1.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _passwordController,
                    obscureText: obscured,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _passwordValidate = false;
                        });
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                        RegExp('[ ]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.security),
                      errorText: _passwordValidate
                          ? 'Password field cannot be empty'
                          : null,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (obscured) {
                              obscured = false;
                            } else {
                              obscured = true;
                            }
                          });
                        },
                        icon: Icon(
                          obscured ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: FlatButton(
                      child: Text('Forgot Password?'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ForgotPassword();
                          }),
                        );
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    if (_emailController.text.isEmpty) {
                      setState(() {
                        _emailValidate = true;
                      });
                    } else if (_passwordController.text.isEmpty) {
                      setState(() {
                        _passwordValidate = true;
                      });
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      setState(() {
                        isLoading = true;
                        _emailValidate = false;
                        _passwordValidate = false;
                      });

                      try {
                        UserCredential user = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        if (user != null) {
                          DocumentReference users = FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.user.uid);

                          users.get().then((snapshot) async {
                            // Store data in shared preferences

                            await prefs.setString(
                              'studentName',
                              snapshot['firstName'] +
                                  ' ' +
                                  snapshot['lastName'],
                            );
                            await prefs.setString(
                              'studentEmail',
                              snapshot['email'],
                            );
                            await prefs.setString(
                              'studentPhone',
                              snapshot['phone'],
                            );
                            await prefs.setString(
                              'studentDepartment',
                              snapshot['department'],
                            );
                            await prefs.setString(
                              'studentLevel',
                              snapshot['level'],
                            );

                            // Navigate to dashboard after storin the data in shared preferences

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen();
                              },
                            ), (Route<dynamic> route) => false);
                          });
                        }
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        _emailController.text = '';
                        _passwordController.text = '';

                        switch (e.code) {
                          case 'unknown':
                            return SweetAlert.show(
                              context,
                              title: 'Error!',
                              subtitle: 'No or Slow internet connection',
                              style: SweetAlertStyle.error,
                            );
                            break;
                          case 'wrong-password':
                            return _showDialog(context);
                            break;
                          case 'invalid-email':
                            return SweetAlert.show(
                              context,
                              title: 'Error!',
                              subtitle: 'Invalid email provided',
                              style: SweetAlertStyle.error,
                            );
                            break;
                          default:
                            return SweetAlert.show(
                              context,
                              title: 'Error!',
                              subtitle: 'A login error occured',
                              style: SweetAlertStyle.error,
                            );
                            break;
                        }
                      }
                    }
                  },
                  child: isLoading
                      ? NutsActivityIndicator(
                          activeColor: Colors.white,
                        )
                      : Text(
                          'Signin',
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
