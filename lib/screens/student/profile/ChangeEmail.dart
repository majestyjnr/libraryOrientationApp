import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class ChangeEmail extends StatefulWidget {
  ChangeEmail({Key key}) : super(key: key);

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  bool isLoading = false;
  bool _emailValidate = false;
  TextEditingController _emailNew = new TextEditingController();

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
          'Change Email',
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
                  controller: _emailNew,
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
                    labelText: 'Enter New Email',
                    errorText:
                        _emailValidate ? 'Email field cannot be empty' : null,
                    prefixIcon: Icon(Icons.security),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
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
                    if (_emailNew.text.isEmpty) {
                      setState(() {
                        _emailValidate = true;
                      });
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      setState(() {
                        isLoading = true;
                      });
                      if (_emailNew.text != null) {
                        User userCurrent = FirebaseAuth.instance.currentUser;
                        userCurrent
                            .updateEmail(_emailNew.text)
                            .then((value) async {
                          // Remove Old Email
                          prefs.remove('studentEmail');
                          // Set New Email
                          await prefs.setString(
                            'studentEmail',
                            _emailNew.text,
                          );
                          // Display Alert
                          SweetAlert.show(context,
                              title: 'Success!',
                              subtitle: 'Email changed successfully',
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
                          _emailNew.text = '';
                        }).catchError(() {
                          setState(
                            () {
                              isLoading = false;
                            },
                          );
                          SweetAlert.show(
                            context,
                            title: 'Error!',
                            subtitle: 'Email changing failed!',
                            style: SweetAlertStyle.error,
                          );
                        });
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
