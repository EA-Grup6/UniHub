import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/feed_controller.dart';
import 'package:unihub_app/models/feedPublication.dart';
import 'package:unihub_app/widgets/feedPostSection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FeedScreen extends StatefulWidget {
  Feed createState() => Feed();
}

class Feed extends State<FeedScreen> {
  String username;

  @override
  void initState() {
    getUsername();
    getAllFeeds();
    //Aquí se llama a la API cuando cargamos esta vista
    super.initState();
  }

  getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.username = prefs.getString('username');
    });
  }

  final TextEditingController contentController = TextEditingController();

  Future<List<FeedPublication>> getAllFeeds() async {
    http.Response response = await FeedController().getFeedPubs();
    List<FeedPublication> preFeedList = [];
    for (var feedPub in jsonDecode(response.body)) {
      preFeedList.add(FeedPublication.fromMap(feedPub));
      print(FeedPublication.fromMap(feedPub));
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
                  child: SingleChildScrollView(
                      padding: EdgeInsets.all(10),
                      child: ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (FeedPublication publication
                                  in snapshot.data.reversed)
                                new FeedPostSection(
                                  publication.username,
                                  publication.content,
                                  publication.publicationDate,
                                  publication.likes,
                                  publication.comments,
                                  this.username,
                                ),
                            ],
                          )))),
              floatingActionButton: FloatingActionButton(
                heroTag: "btnAddFeed",
                child: Icon(Icons.add),
                onPressed: () {
                  showAlertDialog(context);
                },
              ));
        } else {
          return Scaffold(
              appBar: AppBar(
                title: Text("Feed"),
              ),
              body: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text('No posts available')],
              )),
              floatingActionButton: FloatingActionButton(
                heroTag: "btnAddFeed",
                child: Icon(Icons.add),
                onPressed: () {
                  showAlertDialog(context);
                },
              ));
        }
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget submitButton = TextButton(
      child: Text("Create new post"),
      onPressed: () async {
        //Submit post
        await FeedController().createFeedPub(
            this.username, contentController.text, DateTime.now().toString());
        Navigator.pop(context);
      },
    );
    Widget dismissButton = TextButton(
      child: Text("Discard post"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        content: TextFormField(
          controller: contentController,
          keyboardType: TextInputType.multiline,
          minLines: 4,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: 'New post',
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
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
}
