import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/editProfile_controller.dart';
import 'package:unihub_app/controllers/feed_controller.dart';
import 'package:unihub_app/models/feedPublication.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/screens/comments/comments.dart';
import 'package:unihub_app/screens/profile/Profile.dart';

class FeedPost extends StatefulWidget {
  const FeedPost(this.feed, this._myUsername);

  FeedPostSection createState() => FeedPostSection();
  final FeedPublication feed;
  final String _myUsername;
}

class FeedPostSection extends State<FeedPost> {
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
                              UserApp user = UserApp.fromMap(jsonDecode(
                                  await EditProfileController()
                                      .getProfile(widget.feed.username)));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                          widget._myUsername, user)));
                            })),
                    contentPadding: EdgeInsets.all(0),
                    title: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('#' + widget.feed.username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                )),
                            Text(
                                Jiffy(widget.feed.publicationDate)
                                    .fromNow()
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.0,
                                    color: Colors.grey[600])),
                          ],
                        )),
                    subtitle: Text(this.widget.feed.content),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                            icon: this
                                    .widget
                                    .feed
                                    .likes
                                    .contains(this.widget._myUsername)
                                ? Icon(Icons.favorite_rounded,
                                    color: Colors.red)
                                : Icon(Icons.favorite_outline_rounded),
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            alignment: Alignment.center,
                            onPressed: () async {
                              if (!this
                                  .widget
                                  .feed
                                  .likes
                                  .contains(this.widget._myUsername)) {
                                await FeedController().setLikes(
                                    this.widget._myUsername,
                                    'add',
                                    this.widget.feed.id);
                                setState(() {
                                  this
                                      .widget
                                      .feed
                                      .likes
                                      .add(this.widget._myUsername);
                                });
                              } else {
                                await FeedController().setLikes(
                                    this.widget._myUsername,
                                    'remove',
                                    this.widget.feed.id);
                                setState(() {
                                  this
                                      .widget
                                      .feed
                                      .likes
                                      .remove(this.widget._myUsername);
                                });
                              }
                            }),
                        Expanded(
                          child: Text(this.widget.feed.likes.length.toString()),
                        ),
                        IconButton(
                            icon: Icon(Icons.messenger_outline_rounded),
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            alignment: Alignment.center,
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => CommentsScreen(
                                          this.widget.feed,
                                          this.widget._myUsername)))
                                  .then((newComments) {
                                if (newComments != null) {
                                  setState(() {
                                    this.widget.feed.comments = newComments;
                                  });
                                } else {
                                  setState(() {
                                    this.widget.feed.comments = [];
                                  });
                                }
                              });
                            }),
                        Expanded(
                          child:
                              Text(this.widget.feed.comments.length.toString()),
                        ),
                        IconButton(
                            icon: Icon(Icons.share_outlined),
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            alignment: Alignment.center,
                            onPressed: () {
                              //Te tiene que llevar al dialogo para compartir el feed
                            })
                      ])
                ]));
          } else {
            return Container();
          }
        });
  }

  getUserImage() async {
    String urlImage =
        await FeedController().getUserImage(this.widget.feed.username);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String language = prefs.getString('lang');
      await Jiffy.locale(language);
    } catch (exception) {
      await Jiffy.locale('en');
    }
    return urlImage;
  }
}
