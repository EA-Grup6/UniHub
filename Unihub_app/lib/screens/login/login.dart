import 'package:flutter/material.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/routes/apibasehelper.dart';
/*
import 'package:htpp/http.dart';
import 'package:flurest/networking/api_exceptions.dart';
import 'dart:async';
*/

class LoginScreen extends StatefulWidget {
  Login createState() => Login();
}

class Login extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Image.asset('assets/images/unihubLogo.png',
                    height: 300, width: 300),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    obscureText: _isHidden,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      alignLabelWithHint: true,
                      suffix: InkWell(
                        onTap: _tooglePasswordView,
                        child: Icon(
                          _isHidden ? Icons.visibility : Icons.visibility_off,
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
                            child:
                                Text('Sign in', style: TextStyle(fontSize: 20)),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(250, 40)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () {
                              print(nameController.text);
                              print(passwordController.text);
                              ApiBaseHelper().post('/User/loginUser', {
                                'username': nameController.text,
                                'password': passwordController.text
                              });
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
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(140, 40)),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              foregroundColor: MaterialStateProperty.all<Color>(
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
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(140, 40)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blueAccent),
                              foregroundColor: MaterialStateProperty.all<Color>(
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
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      child: Text('Forgot Password'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
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
            )));
  }

  void _tooglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
