import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/feed_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/screens/profile/Profile.dart';

class Profile extends StatefulWidget {
  const Profile(this.user);

  ProfileSection createState() => ProfileSection();
  final UserApp user;
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
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String myUsername = prefs.getString('username');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen(
                                            username: myUsername,
                                            currentUser: this.widget.user)));
                              })),
                      contentPadding: EdgeInsets.all(0),
                      title: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.user.fullname,
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
                                              .text("university", null),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(widget.user.university),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLocalizations.instance.text(
                                                  "profile_subjectsDone",
                                                  null) +
                                              ": ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(widget.user.subjectsDone.join(', ')),
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
                                              .text("degree", null),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(widget.user.degree),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLocalizations.instance.text(
                                                  "profile_subjectsAsking",
                                                  null) +
                                              ": ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(widget.user.subjectsRequested
                                          .join(', ')),
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
        await FeedController().getUserImage(this.widget.user.username);
    return urlImage;
  }
}
