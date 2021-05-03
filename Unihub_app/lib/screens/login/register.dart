import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/register_controller.dart';

import '../../controllers/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  Register createState() => Register();
}

class Register extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/images/unihubLogo.png',
                            height: 250, width: 250),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
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
                            obscureText: _isHidden,
                            validator: (val) =>
                                val.isEmpty ? 'Enter a password' : null,
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
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: TextFormField(
                            obscureText: _isHidden,
                            validator: (val) =>
                                val.isEmpty ? 'Repeat password' : null,
                            controller: _password2Controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Repeat password',
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
                                      child: Text('Sign up',
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
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          print(_nameController.text);
                                          print(_passwordController.text);
                                          var response = RegisterController()
                                              .registerUser(
                                                  _nameController.text,
                                                  _passwordController.text);
                                          Navigator.of(context)
                                              .pushNamed('/editProfile');
                                        }
                                      }),
                                  SizedBox(height: 12.0),
                                  Text(
                                    error,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14.0),
                                  )
                                ])),
                      ],
                    )))));
  }

  void _tooglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
