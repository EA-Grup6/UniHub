import 'package:flutter/material.dart';
import 'package:unihub_app/screens/search/searchFeedPublications.dart';
import 'package:unihub_app/screens/search/searchOffers.dart';
import 'package:unihub_app/screens/search/searchProfiles.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Feed Publications'),
                Tab(
                  text: 'Offers',
                ),
                Tab(text: 'Profiles'),
              ],
            ),
            title: Text('Search'),
          ),
          body: TabBarView(
            children: [
              SearchFeedPubsScreen(),
              SearchOffersScreen(),
              SearchProfilesScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
