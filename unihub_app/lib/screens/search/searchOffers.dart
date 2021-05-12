import 'package:flutter/material.dart';

class SearchOffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
                child: Text(
          'Search Offers Screen',
          style: TextStyle(fontSize: 21),
        ))));
  }
}
