import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:unihub_app/controllers/comment_controller.dart';
import 'package:unihub_app/controllers/feed_controller.dart';
import 'package:unihub_app/models/comment.dart';
import 'package:unihub_app/screens/profile/Profile.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget(this.comment, this._myUsername);

  CommentSection createState() => CommentSection();
  final Comment comment;
  final String _myUsername;
}

class CommentSection extends State<CommentWidget> {
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
                                      builder: (context) => ProfileScreen(
                                          widget.comment.username)));
                            })),
                    contentPadding: EdgeInsets.all(0),
                    title: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('#' + widget.comment.username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                )),
                            Text(
                                Jiffy(widget.comment.publicationDate)
                                    .fromNow()
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.0,
                                    color: Colors.grey[600])),
                          ],
                        )),
                    subtitle: Text(this.widget.comment.content),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: <
                      Widget>[
                    IconButton(
                        icon: this
                                .widget
                                .comment
                                .likes
                                .contains(this.widget._myUsername)
                            ? Icon(Icons.favorite_rounded, color: Colors.red)
                            : Icon(Icons.favorite_outline_rounded),
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        alignment: Alignment.center,
                        onPressed: () async {
                          if (!this
                              .widget
                              .comment
                              .likes
                              .contains(this.widget._myUsername)) {
                            await CommentController().setLikes(
                                this.widget._myUsername,
                                'add',
                                this.widget.comment.id);
                            setState(() {
                              this
                                  .widget
                                  .comment
                                  .likes
                                  .add(this.widget._myUsername);
                            });
                          } else {
                            await CommentController().setLikes(
                                this.widget._myUsername,
                                'remove',
                                this.widget.comment.id);
                            setState(() {
                              this
                                  .widget
                                  .comment
                                  .likes
                                  .remove(this.widget._myUsername);
                            });
                          }
                        }),
                    Expanded(
                      child: Text(this.widget.comment.likes.length.toString()),
                    ),
                  ])
                ]));
          } else {
            return Container();
          }
        });
  }

  getUserImage() async {
    String urlImage =
        await FeedController().getUserImage(this.widget.comment.username);
    return urlImage;
  }
}
