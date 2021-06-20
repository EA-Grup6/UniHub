import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/comment_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/models/comment.dart';
import 'package:unihub_app/models/feedPublication.dart';
import 'package:unihub_app/widgets/commentSection.dart';
import 'package:http/http.dart' as http;
import 'package:unihub_app/widgets/feedPostSection.dart';
import 'package:unihub_app/screens/login/login.dart';

class CommentsScreen extends StatefulWidget {
  final FeedPublication feedPublication;
  final String username;
  CommentsScreen(this.feedPublication, this.username);
  CommentState createState() => CommentState();
}

class CommentState extends State<CommentsScreen> {
  List<Comment> commentsList = [];

  TextEditingController contentController = TextEditingController();

  Future<List<Comment>> getAllComments(feedId) async {
    http.Response response =
        await CommentController().getComments(this.widget.feedPublication.id);
    List<Comment> preCommentList = [];
    for (var comment in jsonDecode(response.body)) {
      print(comment.toString());
      preCommentList.add(Comment.fromMap(comment));
    }
    print(preCommentList.toSet().toString());
    return preCommentList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>>(
        future: getAllComments(this.widget.feedPublication.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            this.commentsList = new List<Comment>.from(snapshot.data.reversed);
            return Scaffold(
              appBar: AppBar(
                title:
                    Text(AppLocalizations.instance.text("comments_feedDetail")),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: SafeArea(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          FeedPost(this.widget.feedPublication,
                              this.widget.username),
                          for (Comment newComment in snapshot.data.reversed)
                            new Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: newComment.username == this.widget.username
                                  ? Dismissible(
                                      key: ObjectKey(newComment),
                                      child: CommentWidget(
                                          newComment, this.widget.username),
                                      confirmDismiss: (direction) {
                                        if (newComment.username ==
                                            this.widget.username) {
                                          return showDeletePostAlertDialog(
                                              context, newComment);
                                        } else {
                                          return null;
                                        }
                                      },
                                      onDismissed: (direction) {})
                                  : CommentWidget(
                                      newComment, this.widget.username),
                            )
                        ],
                      ))),
              bottomSheet: TextField(
                style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
                controller: contentController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send_rounded,
                        color: this.contentController.text == ''
                            ? Colors.grey
                            : Colors.blue[400]),
                    onPressed: () async {
                      if (contentController.text != '') {
                        http.Response response = await CommentController()
                            .addComment(
                                this.widget.username,
                                contentController.text,
                                DateTime.now().toString(),
                                this.widget.feedPublication.id);
                        if (response.statusCode == 200) {
                          createToast(
                              AppLocalizations.instance
                                  .text("comments_commentCreatedOK"),
                              Colors.green);
                          setState(() {
                            commentsList.insert(
                                0, Comment.fromMap(jsonDecode(response.body)));
                            contentController = new TextEditingController();
                          });
                        }
                      } else {
                        createToast(
                            AppLocalizations.instance
                                .text("comments_commentError"),
                            Colors.yellow);
                      }
                    },
                  ),
                  hintText:
                      AppLocalizations.instance.text("comments_newComment"),
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.grey[400], width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.grey[500], width: 1),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title:
                    Text(AppLocalizations.instance.text("comments_feedDetail")),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child:
                    FeedPost(this.widget.feedPublication, this.widget.username),
              )),
              bottomSheet: TextField(
                style: TextStyle(color: Colors.grey[800], fontSize: 14.0),
                controller: contentController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send_rounded,
                        color: this.contentController.text == ''
                            ? Colors.grey
                            : Colors.blue[400]),
                    onPressed: () async {
                      if (contentController.text != '') {
                        http.Response response = await CommentController()
                            .addComment(
                                this.widget.username,
                                contentController.text,
                                DateTime.now().toString(),
                                this.widget.feedPublication.id);
                        if (response.statusCode == 200) {
                          createToast(
                              AppLocalizations.instance
                                  .text("comments_commentCreatedOK"),
                              Colors.green);
                          setState(() {
                            commentsList.insert(
                                0, Comment.fromMap(jsonDecode(response.body)));
                            contentController = new TextEditingController();
                          });
                        }
                      } else {
                        createToast(
                            AppLocalizations.instance
                                .text("comments_commentError"),
                            Colors.yellow);
                      }
                    },
                  ),
                  hintText:
                      AppLocalizations.instance.text("comments_newComment"),
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.grey[400], width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.grey[500], width: 1),
                  ),
                ),
              ),
            );
          }
        });
  }

  showDeletePostAlertDialog(BuildContext context, Comment comment) {
    // set up the buttons
    Widget submitButton = TextButton(
      child: Text(AppLocalizations.instance.text("yes")),
      onPressed: () async {
        //delete post
        await CommentController().deleteComment(comment.id).whenComplete(() {
          setState(() {
            this.commentsList.remove(comment);
          });
          Navigator.pop(context);
        });
      },
    );
    Widget dismissButton = TextButton(
      child: Text(AppLocalizations.instance.text("no")),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        content:
            Text(AppLocalizations.instance.text("comments_deleteConfirmation")),
        actions: [dismissButton, submitButton]);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
