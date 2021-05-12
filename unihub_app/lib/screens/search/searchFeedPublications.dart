import 'package:flutter/material.dart';

class SearchFeedPubsScreen extends StatelessWidget {
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
