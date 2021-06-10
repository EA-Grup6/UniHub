import 'package:flutter/material.dart';

class SearchProfilesScreen extends StatelessWidget {
  final String keyword;
  final List<String> fields;

  SearchProfilesScreen(this.fields, this.keyword);

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
