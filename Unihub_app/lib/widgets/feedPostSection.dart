import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:unihub_app/controllers/feed_controller.dart';

class FeedPostSection extends StatelessWidget {
  Image _image;
  final String _id;
  final String _username;
  final String _content;
  final DateTime publicationDate;
  final List<dynamic> _likes;
  final List<dynamic> _comments;

  FeedPostSection(this._id, this._username, this._content, this.publicationDate,
      this._likes, this._comments);
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
                              //Te tiene que llevar al perfil del usuario
                            })),
                    contentPadding: EdgeInsets.all(0),
                    title: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('#$_username',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                )),
                            Text(Jiffy(publicationDate).fromNow().toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.0,
                                    color: Colors.grey[600])),
                          ],
                        )),
                    subtitle: Text(this._content),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.favorite_outline_rounded),
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            alignment: Alignment.center,
                            onPressed: () {
                              //Tiene que añadir tu username a la lista de likes
                            }),
                        IconButton(
                            icon: Icon(Icons.messenger_outline_rounded),
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            alignment: Alignment.center,
                            onPressed: () {
                              //Te tiene que llevar a los comentarios (nueva vista)
                            }),
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget submitButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {
        //delete post
        await FeedController().deleteFeedPost(this._id).whenComplete(() {
          Navigator.pop(context);
        });
      },
    );
    Widget dismissButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        content: Text('Are you sure that you want to delete this post?'),
        actions: [dismissButton, submitButton]);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getUserImage() async {
    String urlImage = await FeedController().getUserImage(this._username);
    print(urlImage);
    return urlImage;
  }
}
