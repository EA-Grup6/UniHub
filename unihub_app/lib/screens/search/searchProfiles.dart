import 'package:flutter/material.dart';

class SearchProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
                child: Text(
          'Search Profiles Screen',
          style: TextStyle(fontSize: 21),
        ))));
  }
}
