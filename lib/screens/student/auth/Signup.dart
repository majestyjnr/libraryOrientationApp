import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool obscured = true;
  String dropdownValue = '100';
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    decoration: InputDecoration(
                      hintText: 'Firstname',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person),
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
                    decoration: InputDecoration(
                      hintText: 'Lastname',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person),
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
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.mail),
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
                          '100',
                          '200',
                          '300',
                          '400',
                          '500',
                          '600'
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text('Level $value'),
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
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
                    try {
                      FirebaseUser user = (await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _email.text,
                        password: _password.text,
                      )).user;

                      if (user != null) {
                        print('Created');
                      }
                    } catch (e) {
                      print(e);
                      _email.text = '';
                      _password.text = '';
                    }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return HomeScreen(title: 'Library App');
                    //     },
                    //   ),
                    // );
                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(fontSize: 20, color: Colors.white),
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
    );
  }
}
