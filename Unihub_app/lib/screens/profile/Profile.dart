import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/editProfile_controller.dart';
import 'package:unihub_app/controllers/login_controller.dart';
import 'package:unihub_app/controllers/social_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/networking/google_signin_api.dart';
import 'package:unihub_app/screens/editProfile/editProfile.dart';
import 'package:unihub_app/screens/login/login.dart';
import 'package:unihub_app/screens/settings/settings.dart';
import 'package:unihub_app/widgets/textSection.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(this.username, this.currentUser);
  final String username;
  final UserApp currentUser;
  Profile createState() => Profile();
}

class Profile extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: this.widget.username == this.widget.currentUser.username
              ? Text(AppLocalizations.instance
                  .text('profile_yourProfileTitle', null))
              : Text(AppLocalizations.instance.text('profile_otherProfileTitle',
                  {'fullname': this.widget.currentUser.fullname})),
          actions: this.widget.username == this.widget.currentUser.username
              ? <Widget>[
                  IconButton(
                      icon: Icon(Icons.brush_rounded),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(this.widget.currentUser),
                        ))
                            .then((result) {
                          if (result != null) {
                            print('Updated profile');
                            setState(() {
                              this.widget.currentUser.updateUser(result);
                            });
                          }
                        });
                      }),
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        //Nos lleva a settings
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => SettingsScreen()))
                            .then((result) {
                          setState(() {});
                        });
                      }),
                  IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () async {
                        logOut(context);
                      })
                ]
              : <Widget>[
                  this
                          .widget
                          .currentUser
                          .followers
                          .contains(this.widget.username)
                      ? TextButton(
                          child: Text(
                              AppLocalizations.instance
                                  .text('profile_unfollow', null),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.grey[800])),
                          onPressed: () async {
                            //Funcion para quitar follow
                            http.Response response = await SocialController()
                                .unfollow(this.widget.currentUser.username,
                                    this.widget.username);
                            if (response.statusCode == 200) {
                              setState(() {
                                this
                                    .widget
                                    .currentUser
                                    .followers
                                    .remove(this.widget.username);
                              });
                              createToast(
                                  AppLocalizations.instance
                                          .text('profile_youUnfollowed', null) +
                                      this.widget.currentUser.username,
                                  Colors.green);
                            } else {
                              createToast(jsonDecode(response.body)['message'],
                                  Colors.green);
                            }
                          })
                      : TextButton(
                          child: Text(
                              AppLocalizations.instance
                                  .text('profile_follow', null),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red[800])),
                          onPressed: () async {
                            //Funcion para añadir follow
                            http.Response response = await SocialController()
                                .follow(this.widget.currentUser.username,
                                    this.widget.username);
                            if (response.statusCode == 200) {
                              setState(() {
                                this
                                    .widget
                                    .currentUser
                                    .followers
                                    .add(this.widget.username);
                              });
                              createToast(
                                  AppLocalizations.instance
                                          .text('profile_youFollowed', null) +
                                      this.widget.currentUser.username,
                                  Colors.green);
                            } else {
                              createToast(jsonDecode(response.body)['message'],
                                  Colors.green);
                            }
                          })
                ],
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView(children: [
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                      child: Stack(children: [
                    Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(0, 2))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  this.widget.currentUser.profilePhoto),
                            ))),
                  ])),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextSection(
                          AppLocalizations.instance
                              .text('profile_fullname', null),
                          this.widget.currentUser.fullname),
                      TextSection(
                          AppLocalizations.instance
                              .text('profile_description', null),
                          this.widget.currentUser.description),
                      TextSection(
                          AppLocalizations.instance.text('profile_role', null),
                          this.widget.currentUser.role),
                      TextSection(
                          AppLocalizations.instance.text('university', null),
                          this.widget.currentUser.university == null ||
                                  this.widget.currentUser.university ==
                                      "Not Selected"
                              ? AppLocalizations.instance
                                  .text('notselected', null)
                              : this.widget.currentUser.university),
                      TextSection(
                          AppLocalizations.instance.text('degree', null),
                          this.widget.currentUser.degree == null ||
                                  this.widget.currentUser.degree ==
                                      "Not Selected"
                              ? AppLocalizations.instance
                                  .text('notselected', null)
                              : this.widget.currentUser.degree),
                      TextSection(
                          AppLocalizations.instance
                              .text('profile_subjectsDone', null),
                          this.widget.currentUser.subjectsDone.length == 0
                              ? AppLocalizations.instance.text('none', null)
                              : this
                                  .widget
                                  .currentUser
                                  .subjectsDone
                                  .join(', ')),
                      TextSection(
                          AppLocalizations.instance
                              .text('profile_subjectsAsking', null),
                          this.widget.currentUser.subjectsRequested.length == 0
                              ? AppLocalizations.instance.text('none', null)
                              : this
                                  .widget
                                  .currentUser
                                  .subjectsRequested
                                  .join(', ')),
                      TextSection(
                          AppLocalizations.instance.text('profile_email', null),
                          this.widget.currentUser.username),
                      TextSection(
                          AppLocalizations.instance.text('profile_phone', null),
                          this.widget.currentUser.phone),
                      TextSection(
                          AppLocalizations.instance
                              .text('profile_followers', null),
                          this.widget.currentUser.followers.length.toString()),
                      TextSection(
                          AppLocalizations.instance
                              .text('profile_following', null),
                          this.widget.currentUser.following.length.toString()),
                      this.widget.username == this.widget.currentUser.username
                          ? Column(children: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                ),
                                child: Text(
                                  AppLocalizations.instance
                                      .text('profile_deleteAccount', null),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onPressed: () async {
                                  showAlertDialog(
                                      context, this.widget.currentUser);
                                },
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                ),
                                child: Text(
                                  AppLocalizations.instance
                                      .text('profile_deleteAccountGDPR', null),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onPressed: () async {
                                  showAlertDialog2(
                                      context, this.widget.currentUser);
                                },
                              ),
                            ])
                          : Container(),
                      /*
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                ),
                                child: Text(
                                  'Erase Your Data GDPR',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onPressed: () async {
                                  showAlertDialog2(context);
                                },
                              )*/
                    ],
                  ),
                ]))));
  }

  logOut(BuildContext context) async {
    try {
      await GoogleSignInApi.logout();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    } catch (exception) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }
  }
}

showAlertDialog(BuildContext context, UserApp user) {
  TextEditingController passwordController = new TextEditingController();
  // set up the buttons
  Widget confirmButton = TextButton(
    child: Text(AppLocalizations.instance.text('confirm', null)),
    onPressed: () async {
      // Delete account checking if password is correct
      http.Response isPasswordOK = await LoginController()
          .loginUser(user.username, passwordController.text);
      if (isPasswordOK == 200) {
        http.Response response =
            await EditProfileController().deleteProfile(user.username);
        if (response.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          createToast(
              AppLocalizations.instance.text('profile_deleteAccountOK', null),
              Colors.green);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        } else {
          createToast(
              AppLocalizations.instance.text('profile_deleteAccountNO', null),
              Colors.red);
        }
      } else {
        createToast(
            AppLocalizations.instance.text('wrongPassword', null), Colors.red);
      }
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(AppLocalizations.instance
        .text('profile_deleteAccountConfirmation', null)),
    content: TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: AppLocalizations.instance
              .text("profile_deleteAccountConfirmPassword", null),
          floatingLabelBehavior: FloatingLabelBehavior.always),
    ),
    actions: [cancelButton, confirmButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

/////////////////////

showAlertDialog2(BuildContext context, UserApp user) {
  TextEditingController passwordController = new TextEditingController();
  // set up the buttons
  Widget confirmButton = TextButton(
    child: Text(AppLocalizations.instance.text('confirm', null)),
    onPressed: () async {
      // Delete account checking if password is correct
      http.Response isPasswordOK = await LoginController()
          .loginUser(user.username, passwordController.text);
      if (isPasswordOK == 200) {
        http.Response response =
            await EditProfileController().deleteProfile(user.username);
        if (response.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          createToast(
              AppLocalizations.instance.text('profile_deleteAccountOK', null),
              Colors.green);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        } else {
          createToast(
              AppLocalizations.instance.text('profile_deleteAccountNO', null),
              Colors.red);
        }
      } else {
        createToast(
            AppLocalizations.instance.text('wrongPassword', null), Colors.red);
      }
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(AppLocalizations.instance
        .text('profile_deleteAccountConfirmationGDPR', null)),
    content: TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: AppLocalizations.instance
              .text("profile_deleteAccountConfirmPassword", null),
          floatingLabelBehavior: FloatingLabelBehavior.always),
    ),
    actions: [cancelButton, confirmButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void setFollow() {}
