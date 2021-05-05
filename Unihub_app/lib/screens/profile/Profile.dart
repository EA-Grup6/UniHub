import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/editProfile_controller.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/widgets/textSection.dart';

String finalUsername;
UserApp currentUser;

class ProfileScreen extends StatefulWidget {
  Profile createState() => Profile();
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

class Profile extends State<ProfileScreen> {
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      currentUser = UserApp.fromMap(
          jsonDecode(await EditProfileController().getProfile(finalUsername)));
    });
    super.initState();
  }

  Future getValidationData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var username = preferences.getString('username');
    setState(() {
      finalUsername = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                          color: Theme.of(context).scaffoldBackgroundColor),
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
                              "https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg"))),
                ),
              ])),
              SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextSection("Username", currentUser.fullname),
                  TextSection("Description", currentUser.description),
                  TextSection("Role", currentUser.role),
                  TextSection("University", currentUser.university),
                  TextSection("Degree", currentUser.degree),
                  TextSection(
                      "Subjects already Done", currentUser.subjectsDone),
                  TextSection(
                      "Subjects Asking for", currentUser.subjectsRequested),
                  TextSection("Recomendations", ""),
                  TextSection("E-mail", currentUser.username),
                  TextSection("Phone", currentUser.phone),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/editProfile');
                    this.initState();
                  },
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login', (Route<dynamic> route) => false);
                  },
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: Text(
                    'Delete your account',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () async {
                    showAlertDialog(context);
                  },
                )
              ])
            ])));
  }
}

showAlertDialog(BuildContext context) {
  TextEditingController passwordController = new TextEditingController();
  // set up the buttons
  Widget confirmButton = TextButton(
    child: Text("Confirm"),
    onPressed: () async {
      // Delete account checking if password is correct
      if (passwordController.text == currentUser.password) {
        var status = await EditProfileController().deleteProfile(finalUsername);
        if (status == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          createToast("Account correctly deleted", Colors.green);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        } else {
          createToast("Couldn't delete account", Colors.red);
        }
      } else {
        createToast("Wrong password", Colors.red);
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
    title: Text("Are you sure you want to delete your account?"),
    content: TextFormField(
      controller: passwordController,
      validator: (val) => val.isEmpty ? 'Enter your name' : null,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: "Please confirm with your password",
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
