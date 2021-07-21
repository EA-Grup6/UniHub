import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/feed_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/models/feedPublication.dart';
import 'package:unihub_app/widgets/feedPostSection.dart';

class SearchFeedPubsScreen extends StatefulWidget {
  const SearchFeedPubsScreen(this.fields, this.keyword);
  final String keyword;
  final List<String> fields;
  @override
  SearchFeedPubs createState() => SearchFeedPubs();
}

class SearchFeedPubs extends State<SearchFeedPubsScreen> {
  String username;

  getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.username = prefs.getString('username');
  }

  Future<List<FeedPublication>> initializeListAndUser() async {
    List<FeedPublication> pubsList = [];
    List<FeedPublication> filteredPubList = [];
    getUsername();
    http.Response response = await FeedController().getFeedPubs();
    for (var feedPub in jsonDecode(response.body)) {
      pubsList.add(FeedPublication.fromMap(feedPub));
    }
    pubsList.forEach((FeedPublication feed) {
      this.widget.fields.forEach((String field) {
        List<String> contentToSearch = feed
            .toJSON()[field.toLowerCase()]
            .toString()
            .toLowerCase()
            .split(' ');
        if (contentToSearch.contains(this.widget.keyword)) {
          filteredPubList.add(feed);
        }
      });
    });
    return filteredPubList;
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.keyword != ' ') {
      return FutureBuilder<List<FeedPublication>>(
          future: initializeListAndUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
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
                                  new FeedPost(
                                    publication,
                                    this.username,
                                  ),
                              ],
                            )))),
              );
            } else {
              initializeListAndUser();
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          });
    } else {
      return Scaffold(
          body: Center(
              child: Text(
        AppLocalizations.instance.text("search", null) +
            " " +
            AppLocalizations.instance
                .text("search_feedPubs", null)
                .toLowerCase(),
        style: TextStyle(fontSize: 21),
      )));
    }
  }
}
