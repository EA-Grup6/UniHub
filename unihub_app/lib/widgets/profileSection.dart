import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/feed_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/screens/profile/Profile.dart';

class Profile extends StatefulWidget {
  const Profile(this._fullname, this._username, this._university, this._degree,
      this._doneSubjects, this._askingSubjects);

  ProfileSection createState() => ProfileSection();
  final String _fullname;
  final String
      _username; //Solo para que me lleve a su perfil, no lo mostraré en la Card
  final String _university;
  final String _degree;
  final List<dynamic> _doneSubjects;
  final List<dynamic> _askingSubjects;
}

class ProfileSection extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey[200], width: 1))),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Column(children: [
                  ListTile(
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data),
                          radius: 25,
                          child: IconButton(
                              splashRadius: 25,
                              icon: Icon(null),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileScreen(widget._username)));
                              })),
                      contentPadding: EdgeInsets.all(0),
                      title: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget._fullname,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  )),
                            ],
                          )),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLocalizations.instance
                                              .text("university"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(widget._university),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLocalizations.instance.text(
                                                  "profile_subjectsDone") +
                                              ": ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(widget._doneSubjects.join(', ')),
                                    ]),
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLocalizations.instance
                                              .text("degree"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(widget._degree),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLocalizations.instance.text(
                                                  "profile_subjectsDone") +
                                              ": ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(widget._askingSubjects.join(', ')),
                                    ]),
                              ])
                        ],
                      )),
                ]));
          } else {
            return Container();
          }
        });
  }

  getUserImage() async {
    String urlImage =
        await FeedController().getUserImage(this.widget._username);
    return urlImage;
  }
}
