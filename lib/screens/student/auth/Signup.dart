import 'package:LibraryOrientationApp/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:toast/toast.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool obscured = true;
  bool isLoading = false;
  bool _firstValidate = false;
  bool _lastValidate = false;
  bool _emailValidate = false;
  bool _phoneValidate = false;
  bool _departmentValidate = false;
  bool _passwordValidate = false;
  String dropdownValue = 'Level 100';
  TextEditingController _firstname = new TextEditingController();
  TextEditingController _lastname = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _department = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
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
                      controller: _firstname,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _firstValidate = false;
                          });
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                          RegExp('[ ]'),
                        ),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Firstname',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        errorText: _firstValidate
                            ? 'Firstname field cannot be empty'
                            : null,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 1.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _lastname,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _lastValidate = false;
                          });
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                          RegExp('[ ]'),
                        ),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Lastname',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        errorText: _lastValidate
                            ? 'Lastname field cannot be empty'
                            : null,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 1.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
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
                        errorText: _emailValidate
                            ? 'Email field cannot be empty'
                            : null,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 1.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: _phone,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _phoneValidate = false;
                          });
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                          RegExp('[ ]'),
                        ),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Phone',
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.phone_iphone,
                        ),
                        errorText: _phoneValidate
                            ? 'Phone field cannot be empty'
                            : null,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 1.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _department,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _departmentValidate = false;
                          });
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                          RegExp('[ ]'),
                        ),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Department',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.school),
                        errorText: _departmentValidate
                            ? 'Department field cannot be empty'
                            : null,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 1.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text('Select Level:    '),
                        Spacer(),
                        DropdownButton<String>(
                          value: dropdownValue,
                          items: <String>[
                            'Level 100',
                            'Level 200',
                            'Level 300',
                            'Level 400',
                            'Level 500',
                            'Level 600'
                          ].map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (String newLevel) {
                            setState(() {
                              dropdownValue = newLevel;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 1.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      obscureText: obscured,
                      controller: _password,
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
                        errorText: _passwordValidate
                            ? 'Password field cannot be empty'
                            : null,
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
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FlatButton(
                    color: Colors.blue,
                    onPressed: () async {
                      if (_firstname.text.isEmpty) {
                        setState(() {
                          _firstValidate = true;
                        });
                      } else if (_lastname.text.isEmpty) {
                        setState(() {
                          _lastValidate = true;
                        });
                      } else if (_email.text.isEmpty) {
                        setState(() {
                          _emailValidate = true;
                        });
                      } else if (_phone.text.isEmpty) {
                        setState(() {
                          _phoneValidate = true;
                        });
                      } else if (_department.text.isEmpty) {
                        setState(() {
                          _departmentValidate = true;
                        });
                      } else if (_password.text.isEmpty) {
                        setState(() {
                          _passwordValidate = true;
                        });
                      } else {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          UserCredential user = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _email.text,
                            password: _password.text,
                          );

                          if (user != null) {
                            // Get The Current User
                            User userCurrent =
                                FirebaseAuth.instance.currentUser;

                            // Save the user details into the database
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(userCurrent.uid)
                                .set({
                              'firstName': _firstname.text,
                              'lastName': _lastname.text,
                              'email': _email.text,
                              'phone': _phone.text,
                              'department': _department.text,
                              'level': dropdownValue,
                              'role': 'User'
                            });
                            // updateUser.displayName =
                            //     _firstname.text + ' ' + _lastname.text;
                            // userCurrent.updateProfile(updateUser);

                            await prefs.setString(
                              'studentName',
                              _firstname.text + ' ' + _lastname.text,
                            );
                            await prefs.setString(
                              'studentEmail',
                              _email.text,
                            );
                            await prefs.setString(
                              'studentPhone',
                              _phone.text,
                            );
                            await prefs.setString(
                              'studentDepartment',
                              _department.text,
                            );
                            await prefs.setString(
                              'studentLevel',
                              dropdownValue,
                            );

                            User signInUser = FirebaseAuth.instance.currentUser;
                            signInUser.sendEmailVerification().then((value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreen();
                                },
                              ), (Route<dynamic> route) => false);
                            }).catchError((onError) {
                              print(onError);
                            });
                          }
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          _email.text = '';
                          _password.text = '';

                          switch (e.code) {
                            case 'email-already-exists':
                              return SweetAlert.show(
                                context,
                                title: 'Error!',
                                subtitle: 'Email already exists',
                                style: SweetAlertStyle.error,
                              );
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
                                subtitle: 'An error occured',
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
                            'Signup',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
