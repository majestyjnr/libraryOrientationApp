import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:toast/toast.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool obscured = true;
  bool isLoading = false;
  TextEditingController _passwordNew = new TextEditingController();
  TextEditingController _passwordConfirm = new TextEditingController();

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
          'Change Password',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  obscureText: obscured,
                  controller: _passwordNew,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                      RegExp('[ ]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    labelText: 'Enter New Password',
                    prefixIcon: Icon(Icons.security),
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
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  obscureText: obscured,
                  controller: _passwordConfirm,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                      RegExp('[ ]'),
                    ),
                  ],
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    labelText: 'Confirm New Password',
                    prefixIcon: Icon(Icons.security),
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
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    setState(
                      () {
                        isLoading = true;
                      },
                    );
                    if (_passwordNew.text.isEmpty) {
                      setState(
                        () {
                          isLoading = false;
                        },
                      );
                      SweetAlert.show(
                        context,
                        title: 'Error!',
                        subtitle: 'New password is empty',
                        style: SweetAlertStyle.error,
                      );
                    } else if (_passwordConfirm.text.isEmpty) {
                      setState(
                        () {
                          isLoading = false;
                        },
                      );
                      SweetAlert.show(
                        context,
                        title: 'Error!',
                        subtitle: 'Confirm new password is empty',
                        style: SweetAlertStyle.error,
                      );
                    } else if (_passwordNew.text == _passwordConfirm.text) {
                      try {
                        User userCurrent = FirebaseAuth.instance.currentUser;
                        userCurrent
                            .updatePassword(_passwordNew.text)
                            .then((value) {
                          SweetAlert.show(context,
                              title: 'Success!',
                              subtitle: 'Password changed successfully',
                              cancelButtonColor: Colors.blue,
                              // ignore: missing_return
                              style: SweetAlertStyle.success, onPress: (y) {
                            Navigator.pop(context);
                          });
                          setState(
                            () {
                              isLoading = false;
                            },
                          );
                          _passwordNew.text = '';
                          _passwordConfirm.text = '';
                        }).catchError(() {
                          setState(
                            () {
                              isLoading = false;
                            },
                          );
                          SweetAlert.show(
                            context,
                            title: 'Error!',
                            subtitle: 'Password changing failed!',
                            style: SweetAlertStyle.error,
                          );
                        });
                      } on FirebaseAuthException catch (e) {
                        switch (e.code) {
                          case 'requires-recent-login':
                            return SweetAlert.show(
                              context,
                              title: 'Error!',
                              subtitle: 'A recent login required',
                              style: SweetAlertStyle.error,
                            );
                            break;
                          case 'weak-password':
                            return SweetAlert.show(
                              context,
                              title: 'Error!',
                              subtitle: 'Weak password provided',
                              style: SweetAlertStyle.error,
                            );
                            break;
                          default:
                            return SweetAlert.show(
                              context,
                              title: 'Error!',
                              subtitle: 'An error occured',
                              style: SweetAlertStyle.error,
                            );
                            break;
                        }
                      }
                    } else {
                      setState(
                        () {
                          isLoading = false;
                        },
                      );
                      SweetAlert.show(
                        context,
                        title: 'Error!',
                        subtitle: 'Passwords do not match!',
                        style: SweetAlertStyle.error,
                      );
                    }
                  },
                  child: isLoading
                      ? NutsActivityIndicator(
                          activeColor: Colors.white,
                        )
                      : Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
