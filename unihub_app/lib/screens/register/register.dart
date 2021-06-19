import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/register_controller.dart';
import 'package:http/http.dart' as http;
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/screens/login/login.dart';

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
        body: SafeArea(
            child: SingleChildScrollView(
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
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return AppLocalizations.instance
                                        .text("login_noEmail");
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return AppLocalizations.instance
                                        .text("login_notValidEmail");
                                  }
                                  return null;
                                },
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  alignLabelWithHint: true,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: TextFormField(
                                obscureText: _isHidden,
                                validator: (val) => val.isEmpty
                                    ? AppLocalizations.instance
                                        .text("login_noPassword")
                                    : null,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: AppLocalizations.instance
                                      .text("password"),
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
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return AppLocalizations.instance
                                        .text("login_noPassword");
                                  }
                                  if (_passwordController.text != (value)) {
                                    return AppLocalizations.instance
                                        .text("login_notSamePassword");
                                  }
                                  return null;
                                },
                                controller: _password2Controller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: AppLocalizations.instance
                                      .text("register_repeatPassword"),
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
                                          child: Text(
                                              AppLocalizations.instance
                                                  .text("login_signUp"),
                                              style: TextStyle(fontSize: 20)),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all<Size>(
                                                    Size(250, 40)),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blue),
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              final http.Response response =
                                                  await RegisterController()
                                                      .registerUser(
                                                          _nameController.text,
                                                          _passwordController
                                                              .text);
                                              if (response.statusCode == 200) {
                                                createToast(
                                                    AppLocalizations.instance.text(
                                                        "register_accountCreatedOK"),
                                                    Colors.green);

                                                Navigator.of(context)
                                                    .pushNamed('/login');
                                              } else if (response.statusCode ==
                                                  201) {
                                                createToast(
                                                    AppLocalizations.instance.text(
                                                        "register_accountCreatedSameEmail"),
                                                    Colors.green);
                                              } else {
                                                createToast(
                                                    response.body, Colors.red);
                                              }
                                            }
                                          }),
                                    ])),
                          ],
                        ))))));
  }

  void _tooglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
