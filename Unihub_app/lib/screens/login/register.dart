import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unihub_app/controllers/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  Register createState() => Register();
}

class Register extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
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
                  padding: EdgeInsets.fromLTRB(10,0,10,10),
                  child: TextFormField(
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    controller: usernameController,
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
                    validator: (val) => val.isEmpty ? 'Enter a password' : null,
                    controller: password1Controller,
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
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    obscureText: _isHidden,
                    validator: (val) => val.isEmpty ? 'Repeat password' : null,
                    controller: password2Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Repeat password',
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
                                Text('Sign up', style: TextStyle(fontSize: 20)),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(250, 40)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()){
                                dynamic result = await _auth.registerWithEmailAndPassword(usernameController.text, password1Controller.text);
                                if (result == null){
                                  setState(() => error = 'Please enter a valid email');
                                } else{

                                }
                              }
                            },
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red,fontSize: 14.0),
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
