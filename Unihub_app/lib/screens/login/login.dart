import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/editProfile_controller.dart';
import 'package:unihub_app/controllers/login_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/register_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/networking/google_signin_api.dart';
import 'package:unihub_app/screens/homepage/homepage.dart';
import 'package:unihub_app/screens/login/logged_in_page.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  Login createState() => Login();
}

createToast(String message, Color color) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

class Login extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    return AppLocalizations.instance
                                        .text('login_noEmail');
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return AppLocalizations.instance
                                        .text('login_notValidEmail');
                                  }
                                  return null;
                                },
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: AppLocalizations.instance
                                      .text('username'),
                                  alignLabelWithHint: true,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: TextFormField(
                                validator: (val) => val.isEmpty
                                    ? AppLocalizations.instance
                                        .text('login_noPassword')
                                    : null,
                                obscureText: _isHidden,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: AppLocalizations.instance
                                      .text('password'),
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
                                                .text('login_signIn'),
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
                                          if (_formKey.currentState
                                              .validate()) {
                                            final int response =
                                                await LoginController()
                                                    .loginUser(
                                                        _nameController.text,
                                                        _passwordController
                                                            .text);
                                            if (response == 200) {
                                              final SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setString('username',
                                                  _nameController.text);
                                              createToast(
                                                  AppLocalizations.instance.text(
                                                      'login_loggedCorrectly'),
                                                  Colors.green);
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      '/homepage',
                                                      (Route<dynamic> route) =>
                                                          false);
                                            } else if (response == 201) {
                                              createToast(
                                                  AppLocalizations.instance.text(
                                                      'login_wrongPassword'),
                                                  Colors.red);
                                            } else {
                                              createToast('Error', Colors.red);
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
                                        onPressed: () async {
                                          await signIn();
                                        },
                                        //Login with google
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                  child: Text(AppLocalizations.instance
                                      .text('login_forgotPassword')),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                  ),
                                  child: Text(
                                    AppLocalizations.instance
                                        .text('login_signUp'),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/register');
                                  },
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ))
                          ],
                        ))))));
  }

  void _tooglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future signIn() async {
    final user = await GoogleSignInApi.login();

    http.Response registerResponse =
        await RegisterController().registerUser(user.email, user.id);
    print('register: ' + registerResponse.statusCode.toString());
    if (registerResponse.statusCode == 200) {
      print("User does not exist, registered and now loging in");
      var login = await LoginController().loginUser(user.email, user.id);
      print('login: ' + login.toString());
      if (login == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', user.email);
        if (login == 200) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomepageScreen(),
              ));
        }
      }
    } else if (registerResponse.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', user.email);
      var login = await LoginController().loginUser(user.email, user.id);
      if (login == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomepageScreen(),
            ));
      }
    } else {
      createToast('Error', Colors.red);
    }
  }
}
