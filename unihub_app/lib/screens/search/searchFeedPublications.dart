import 'package:flutter/material.dart';
import 'package:unihub_app/models/feedPublication.dart';

class SearchFeedPubsScreen extends StatelessWidget {
  List<FeedPublication> listaPubs;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
                child: Text(
          'Search Publications Screen',
          style: TextStyle(fontSize: 21),
        ))));
  }
}
