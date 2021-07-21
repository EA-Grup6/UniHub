import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/social_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/widgets/profileSection.dart';

class SearchProfilesScreen extends StatefulWidget {
  const SearchProfilesScreen(this.fields, this.keyword);
  final String keyword;
  final List<String> fields;
  @override
  SearchProfiles createState() => SearchProfiles();
}

class SearchProfiles extends State<SearchProfilesScreen> {
  Future<List<UserApp>> initializeListAndUser() async {
    List<UserApp> profilesList = [];
    List<UserApp> filteredProfilesList = [];
    http.Response response = await SocialController().getProfiles();
    for (var profile in jsonDecode(response.body)) {
      profilesList.add(UserApp.fromMap(profile));
    }
    profilesList.forEach((UserApp user) {
      this.widget.fields.forEach((String field) {
        List<String> contentToSearch = user
            .toJSON()[field.split(' ').join().toLowerCase()]
            .toString()
            .toLowerCase()
            .split(' ');
        if (contentToSearch.contains(this.widget.keyword)) {
          filteredProfilesList.add(user);
        }
      });
    });
    return filteredProfilesList;
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.keyword != ' ') {
      return FutureBuilder<List<UserApp>>(
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
                                for (UserApp user in snapshot.data.reversed)
                                  new Profile(user),
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
                .text("search_profiles", null)
                .toLowerCase(),
        style: TextStyle(fontSize: 21),
      )));
    }
  }
}
