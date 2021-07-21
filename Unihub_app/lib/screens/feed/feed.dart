import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/feed_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/models/feedPublication.dart';
import 'package:unihub_app/screens/addOffer/addOffer.dart';
import 'package:unihub_app/widgets/feedPostSection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FeedScreen extends StatefulWidget {
  List<FeedPublication> pubsList;
  FeedScreen(this.pubsList);
  Feed createState() => Feed();
}

class Feed extends State<FeedScreen> {
  String username;

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.username = prefs.getString('username');
    });
    return this.username;
  }

  final TextEditingController contentController = TextEditingController();

  Future<void> getAllFeeds() async {
    http.Response response = await FeedController().getFeedPubs();
    List<FeedPublication> preFeedList = [];
    for (var feedPub in jsonDecode(response.body)) {
      preFeedList.add(FeedPublication.fromMap(feedPub));
    }
    setState(() {
      this.widget.pubsList = preFeedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    this
        .widget
        .pubsList
        .sort((a, b) => a.publicationDate.compareTo(b.publicationDate));
    if (this.widget.pubsList == null || this.widget.pubsList.length == 0) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Feed"),
          ),
          body: Container(
              child: RefreshIndicator(
            onRefresh: () async {
              getAllFeeds();
            },
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )),
          floatingActionButton: FloatingActionButton(
            heroTag: "btnAddFeed",
            child: Icon(Icons.add),
            onPressed: () {
              showNewPostAlertDialog(context);
            },
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text("Feed"),
          ),
          body: SafeArea(
              child: RefreshIndicator(
                  child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      itemCount: this.widget.pubsList.length,
                      itemBuilder: (context, index) {
                        if (this
                                .widget
                                .pubsList
                                .reversed
                                .elementAt(index)
                                .username ==
                            this.username) {
                          return new Dismissible(
                              key: ObjectKey(this
                                  .widget
                                  .pubsList
                                  .reversed
                                  .elementAt(index)),
                              child: new FeedPost(
                                  this
                                      .widget
                                      .pubsList
                                      .reversed
                                      .elementAt(index),
                                  this.username),
                              confirmDismiss: (direction) {
                                return showDeletePostAlertDialog(
                                    context, index);
                              },
                              onDismissed: (direction) {});
                        } else {
                          return new FeedPost(
                              this.widget.pubsList.reversed.elementAt(index),
                              this.username);
                        }
                      }),
                  onRefresh: () async {
                    await getAllFeeds();
                  })),
          floatingActionButton: FloatingActionButton(
            heroTag: "btnAddFeed",
            child: Icon(Icons.add),
            onPressed: () {
              showNewPostAlertDialog(context);
            },
          ));
    }
  }

  showNewPostAlertDialog(BuildContext context) {
    contentController.text = '';
    // set up the buttons
    Widget submitButton = TextButton(
        child: Text(AppLocalizations.instance.text("feed_createNewPost", null)),
        onPressed: () async {
          //Submit post
          http.Response response = await FeedController().createFeedPub(
              this.username, contentController.text, DateTime.now().toString());
          if (response.statusCode == 200) {
            createToast(
                AppLocalizations.instance
                    .text("feed_correctlyCreatedNewPost", null),
                Colors.green);
            setState(() {
              this.widget.pubsList.insert(
                  0, FeedPublication.fromMap(jsonDecode(response.body)));
            });
            Navigator.pop(context);
          }
        });

    Widget dismissButton = TextButton(
      child: Text(AppLocalizations.instance.text("feed_dismissNewPost", null)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        insetPadding: EdgeInsets.all(10),
        title: Text(AppLocalizations.instance.text("feed_titleNewPost", null)),
        content: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  minLines: 4,
                  maxLines: null,
                  maxLength: 240,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: AppLocalizations.instance
                        .text("feed_subtitleNewPost", null),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                )),
          ],
        ),
        actions: [dismissButton, submitButton]);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDeletePostAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget submitButton = TextButton(
      child: Text(AppLocalizations.instance.text("yes", null)),
      onPressed: () async {
        //delete post
        await FeedController()
            .deleteFeedPost(this.widget.pubsList.reversed.elementAt(index).id)
            .whenComplete(() {
          setState(() {
            this
                .widget
                .pubsList
                .remove(this.widget.pubsList.reversed.elementAt(index));
          });
          Navigator.pop(context);
        });
      },
    );
    Widget dismissButton = TextButton(
      child: Text(AppLocalizations.instance.text("no", null)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        content: Text(AppLocalizations.instance
            .text("feed_deletePostConfirmation", null)),
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
