import 'package:flutter/cupertino.dart';

class FeedPublication {
  final String id;
  final String username;
  final DateTime publicationDate;
  final String content;
  List<dynamic> comments;
  final List<dynamic> likes;

  FeedPublication(
    this.id,
    this.username,
    this.publicationDate,
    this.content,
    this.comments,
    this.likes,
  );

  factory FeedPublication.fromMap(Map<String, dynamic> json) {
    return FeedPublication(
      json['_id'],
      json['username'],
      DateTime.parse(json['publicationDate']),
      json['content'],
      json['comments'],
      json['likes'],
    );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> newJSON = {
      '_id': this.id,
      'username': this.username,
      'publicationDate': this.publicationDate,
      'content': this.content,
      'comments': this.comments,
      'likes': this.likes,
    };
    return newJSON;
  }
}

class ListFeedPublication with ChangeNotifier {
  List<FeedPublication> pubsList;

  ListFeedPublication({this.pubsList});

  getPubs() => this.pubsList;

  void add(FeedPublication feedPub) {
    pubsList.add(feedPub);
    notifyListeners();
  }

  void remove(FeedPublication feedPub) {
    pubsList.remove(feedPub);
    notifyListeners();
  }
}
