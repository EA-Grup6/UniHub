import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/widgets/text_section.dart';

class ProfileScreen extends StatefulWidget {
  Profile createState() => Profile();
}

class Profile extends State<ProfileScreen> {
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
                  TextSection("Username", "Toni Mur"),
                  TextSection("Description",
                      "Soy un estudiante acabando cuarto de carrera con una vocación por la enseñanza, etc etc"),
                  TextSection("Role", "Profesor"),
                  TextSection(
                      "University", "Universitat Politècnica Catalunya"),
                  TextSection("Degree",
                      "Doble titulació en Sistemes Aeroespacials i Telemàtica"),
                  TextSection("Subjects already Done", "blablabla"),
                  TextSection("Subjects Asking for", "bla bla bla"),
                  TextSection("Recomendations", ""),
                  TextSection("E-mail", "toni@mur.com"),
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
                )
              ])
            ])));
  }
}
