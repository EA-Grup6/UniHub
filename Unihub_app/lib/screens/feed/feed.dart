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
  Feed createState() => Feed();
}

class Feed extends State<FeedScreen> {
  String username;
  List<FeedPublication> pubsList;

  @override
  void initState() {
    getUsername();
    //Aquí se llama a la API cuando cargamos esta vista
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

  Future<List<FeedPublication>> getAllFeeds() async {
    http.Response response = await FeedController().getFeedPubs();
    List<FeedPublication> preFeedList = [];
    for (var feedPub in jsonDecode(response.body)) {
      preFeedList.add(FeedPublication.fromMap(feedPub));
    }
    return preFeedList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FeedPublication>>(
      future: getAllFeeds(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Feed"),
              ),
              body: SafeArea(
                  child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data.reversed.elementAt(index).username ==
                            this.username) {
                          this.pubsList = new List<FeedPublication>.from(
                              snapshot.data.reversed);
                          return new Dismissible(
                              key: ObjectKey(this.pubsList.elementAt(index)),
                              child: new FeedPost(
                                  this.pubsList.elementAt(index),
                                  this.username),
                              confirmDismiss: (direction) {
                                if (this.pubsList.elementAt(index).username ==
                                    this.username) {
                                  return showDeletePostAlertDialog(
                                      context, index);
                                } else {
                                  return null;
                                }
                              },
                              onDismissed: (direction) {});
                        } else {
                          return new FeedPost(
                              snapshot.data.reversed.elementAt(index),
                              this.username);
                        }
                      })),
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
              body: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                heroTag: "btnAddFeed",
                child: Icon(Icons.add),
                onPressed: () {
                  showNewPostAlertDialog(context);
                },
              ));
        }
      },
    );
  }

  showNewPostAlertDialog(BuildContext context) {
    contentController.text = '';
    // set up the buttons
    Widget submitButton = TextButton(
        child: Text(AppLocalizations.instance.text("feed_createNewPost")),
        onPressed: () async {
          //Submit post
          http.Response response = await FeedController().createFeedPub(
              this.username, contentController.text, DateTime.now().toString());
          if (response.statusCode == 200) {
            createToast(
                AppLocalizations.instance.text("feed_correctlyCreatedNewPost"),
                Colors.green);
            setState(() {
              pubsList.insert(
                  0, FeedPublication.fromMap(jsonDecode(response.body)));
            });
            Navigator.pop(context);
          }
        });

    Widget dismissButton = TextButton(
      child: Text(AppLocalizations.instance.text("feed_dismissNewPost")),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.all(10),
        title: Text(AppLocalizations.instance.text("feed_titleNewPost")),
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
                    labelText:
                        AppLocalizations.instance.text("feed_subtitleNewPost"),
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
      child: Text(AppLocalizations.instance.text("yes")),
      onPressed: () async {
        //delete post
        await FeedController()
            .deleteFeedPost(this.pubsList.elementAt(index).id)
            .whenComplete(() {
          setState(() {
            this.pubsList.removeAt(index);
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
            Text(AppLocalizations.instance.text("feed_deletePostConfirmation")),
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
