import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/editProfile_controller.dart';
import 'package:unihub_app/controllers/social_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/screens/editProfile/editProfile.dart';
import 'package:unihub_app/screens/login/login.dart';
import 'package:unihub_app/screens/settings/settings.dart';
import 'package:unihub_app/widgets/textSection.dart';

UserApp currentUser;
String imageUser;
Image usrImg;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen(this.username);
  final String username;
  Profile createState() => Profile();
}

class Profile extends State<ProfileScreen> {
  String myUsername;
  String username;

  @override
  void initState() {
    super.initState();
  }

  Future<UserApp> getDataFromUser() async {
    username = this.widget.username;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    myUsername = preferences.getString('username');
    if (username == null) {
      username = myUsername;
    }
    currentUser = UserApp.fromMap(
        jsonDecode(await EditProfileController().getProfile(username)));
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserApp>(
        future: getDataFromUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: this.username == this.myUsername
                      ? Text(AppLocalizations.instance
                          .text('profile_yourProfileTitle'))
                      : Text(currentUser.fullname),
                  actions: this.username == this.myUsername
                      ? <Widget>[
                          IconButton(
                              icon: Icon(Icons.brush_rounded),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditProfileScreen(),
                                        settings: RouteSettings(
                                            arguments: currentUser)));
                              }),
                          IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () {
                                //Nos lleva a settings
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SettingsScreen()));
                              }),
                          IconButton(
                              icon: Icon(Icons.logout),
                              onPressed: () async {
                                logOut(context);
                              })
                        ]
                      : <Widget>[
                          currentUser.followers.contains(this.myUsername)
                              ? TextButton(
                                  child: Text(
                                      AppLocalizations.instance
                                          .text('profile_unfollow'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .all<Color>(Colors.grey[800])),
                                  onPressed: () async {
                                    //Funcion para quitar follow
                                    http.Response response =
                                        await SocialController().unfollow(
                                            this.myUsername,
                                            currentUser.username);
                                    if (response.statusCode == 200) {
                                      setState(() {
                                        currentUser.followers
                                            .remove(this.myUsername);
                                      });
                                      createToast(
                                          AppLocalizations.instance.text(
                                                  'profile_youUnfollowed') +
                                              currentUser.username,
                                          Colors.green);
                                    } else {
                                      createToast(
                                          jsonDecode(response.body)['message'],
                                          Colors.green);
                                    }
                                  })
                              : TextButton(
                                  child:
                                      Text(AppLocalizations.instance.text('profile_follow'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red[800])),
                                  onPressed: () async {
                                    //Funcion para añadir follow
                                    http.Response response =
                                        await SocialController().follow(
                                            this.myUsername,
                                            currentUser.username);
                                    if (response.statusCode == 200) {
                                      setState(() {
                                        currentUser.followers
                                            .remove(this.myUsername);
                                      });
                                      createToast(
                                          AppLocalizations.instance
                                                  .text('profile_youFollowed') +
                                              currentUser.username,
                                          Colors.green);
                                    } else {
                                      createToast(
                                          jsonDecode(response.body)['message'],
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
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
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
                                          currentUser.profilePhoto),
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
                                      .text('profile_fullname'),
                                  currentUser.fullname),
                              TextSection(
                                  AppLocalizations.instance
                                      .text('profile_description'),
                                  currentUser.description),
                              TextSection(
                                  AppLocalizations.instance
                                      .text('profile_role'),
                                  currentUser.role),
                              TextSection(
                                  AppLocalizations.instance.text('university'),
                                  currentUser.university == null
                                      ? AppLocalizations.instance
                                          .text('notselected')
                                      : currentUser.university),
                              TextSection(
                                  AppLocalizations.instance.text('degree'),
                                  currentUser.degree == null
                                      ? AppLocalizations.instance
                                          .text('notselected')
                                      : currentUser.degree),
                              TextSection(
                                  AppLocalizations.instance
                                      .text('profile_subjectsDone'),
                                  currentUser.subjectsDone.length == 0
                                      ? AppLocalizations.instance.text('none')
                                      : currentUser.subjectsDone.join(', ')),
                              TextSection(
                                  AppLocalizations.instance
                                      .text('profile_subjectsAsking'),
                                  currentUser.subjectsRequested.length == 0
                                      ? AppLocalizations.instance.text('none')
                                      : currentUser.subjectsRequested
                                          .join(', ')),
                              TextSection(
                                  AppLocalizations.instance
                                      .text('profile_email'),
                                  currentUser.username),
                              TextSection(
                                  AppLocalizations.instance
                                      .text('profile_phone'),
                                  currentUser.phone),
                              TextSection(
                                  AppLocalizations.instance
                                      .text('profile_followers'),
                                  currentUser.followers.length.toString()),
                              TextSection(
                                  AppLocalizations.instance
                                      .text('profile_following'),
                                  currentUser.following.length.toString()),
                              this.username == myUsername
                                  ? TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red),
                                      ),
                                      child: Text(
                                        AppLocalizations.instance
                                            .text('profile_deleteAccount'),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        showAlertDialog(context);
                                      },
                                    )
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
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ]);
          }
        });
  }

  logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}

showAlertDialog(BuildContext context) {
  TextEditingController passwordController = new TextEditingController();
  // set up the buttons
  Widget confirmButton = TextButton(
    child: Text(AppLocalizations.instance.text('confirm')),
    onPressed: () async {
      // Delete account checking if password is correct
      if (passwordController.text == currentUser.password) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var username = preferences.getString('username');
        http.Response response =
            await EditProfileController().deleteProfile(username);
        if (response.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          createToast(AppLocalizations.instance.text('profile_deleteAccountOK'),
              Colors.green);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        } else {
          createToast(AppLocalizations.instance.text('profile_deleteAccountNO'),
              Colors.red);
        }
      } else {
        createToast(
            AppLocalizations.instance.text('wrongPassword'), Colors.red);
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
    title: Text(
        AppLocalizations.instance.text('profile_deleteAccountConfirmation')),
    content: TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: AppLocalizations.instance
              .text("profile_deleteAccountConfirmPassword"),
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

showAlertDialog2(BuildContext context) {
  TextEditingController passwordController = new TextEditingController();
  // set up the buttons
  Widget confirmButton = TextButton(
    child: Text(AppLocalizations.instance.text('confirm')),
    onPressed: () async {
      // Delete account checking if password is correct
      if (passwordController.text == currentUser.password) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var username = preferences.getString('username');
        http.Response response =
            await EditProfileController().deleteALL(username); //DELETEALL
        if (response.statusCode == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          createToast(AppLocalizations.instance.text('profile_deleteAccountOK'),
              Colors.green);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        } else {
          createToast(AppLocalizations.instance.text('profile_deleteAccountNO'),
              Colors.red);
        }
      } else {
        createToast(
            AppLocalizations.instance.text('wrongPassword'), Colors.red);
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
        .text('profile_deleteAccountConfirmationGDPR')),
    content: TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: AppLocalizations.instance
              .text("profile_deleteAccountConfirmPassword"),
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
