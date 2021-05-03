import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/login_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  Login createState() => Login();
}

class Login extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/images/unihubLogo.png',
                            height: 300, width: 300),
                        Container(
                          alignment: Alignment.center,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Enter an email';
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return 'Please enter a valid Email';
                              }
                              return null;
                            },
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Missing password' : null,
                            obscureText: _isHidden,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              alignLabelWithHint: true,
                              suffix: InkWell(
                                onTap: _tooglePasswordView,
                                child: Icon(
                                  _isHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    child: Text('Sign in',
                                        style: TextStyle(fontSize: 20)),
                                    style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(250, 40)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        print(_nameController.text);
                                        print(_passwordController.text);
                                        final http.Response response =
                                            await LoginController().loginUser(
                                                _nameController.text,
                                                _passwordController.text);
                                        print(response);
                                        if (response.statusCode == 200) {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setString(
                                              'username', _nameController.text);
                                          Fluttertoast.showToast(
                                              msg: "Logged correctly",
                                              toastLength: Toast.LENGTH_SHORT,
                                              timeInSecForIosWeb: 2,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/homepage',
                                                  (Route<dynamic> route) =>
                                                      false);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: response.body,
                                              toastLength: Toast.LENGTH_SHORT,
                                              timeInSecForIosWeb: 2,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      }
                                    },
                                  )
                                ])),
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              children: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      //Login with google
                                    },
                                    style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(140, 40)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: Text(
                                      'Google',
                                      style: TextStyle(fontSize: 20),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      //Login with facebook
                                    },
                                    style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(140, 40)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blueAccent),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    child: Text(
                                      'Facebook',
                                      style: TextStyle(fontSize: 20),
                                    ))
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            )),
                        Container(
                            child: Row(
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                //forgot password screen
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey),
                              ),
                              child: Text('Forgot Password'),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                              ),
                              child: Text(
                                'Sign up',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/register');
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ))
                      ],
                    )))));
  }

  void _tooglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}