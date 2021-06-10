import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/feed_controller.dart';
import 'package:unihub_app/models/feedPublication.dart';
import 'package:unihub_app/widgets/feedPostSection.dart';

class SearchFeedPubsScreen extends StatelessWidget {
  final String keyword;
  String username;

  SearchFeedPubsScreen(this.keyword);

  getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.username = prefs.getString('username');
  }

  Future<List<FeedPublication>> initializeListAndUser() async {
    String field = 'content';
    List<FeedPublication> pubsList = [];
    List<FeedPublication> filteredPubList = [];
    getUsername();
    http.Response response = await FeedController().getFeedPubs();
    for (var feedPub in jsonDecode(response.body)) {
      pubsList.add(FeedPublication.fromMap(feedPub));
    }
    //EL ALGORITMO DE BUSQUEDA ES SOLO ESTO
    pubsList.forEach((FeedPublication feed) {
      List<String> contentToSearch = feed.toJSON()[field].split(' ');
      if (contentToSearch.contains(keyword)) {
        filteredPubList.add(feed);
      }
    });
    return filteredPubList;
    //DEBERÍA HACERLO BACKEND PERO NP
  }

  @override
  Widget build(BuildContext context) {
    if (keyword != null) {
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
                                    publication.id,
                                    publication.username,
                                    publication.content,
                                    publication.publicationDate,
                                    publication.likes,
                                    publication.comments,
                                    this.username,
                                  ),
                              ],
                            )))),
              );
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
    } else {
      return Scaffold();
    }
  }
}
