import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/offer_controller.dart';
import 'package:unihub_app/models/offer.dart';
import 'package:unihub_app/widgets/offerSection.dart';

class SearchOffersScreen extends StatefulWidget {
  const SearchOffersScreen(this.fields, this.keyword);
  final String keyword;
  final List<String> fields;
  @override
  SearchOffers createState() => SearchOffers();
}

class SearchOffers extends State<SearchOffersScreen> {
  String username;

  Future<List<OfferApp>> initializeListAndUser() async {
    List<OfferApp> pubsList = [];
    List<OfferApp> filteredPubList = [];
    http.Response response = await OfferController().getOffers();
    for (var offer in jsonDecode(response.body)) {
      pubsList.add(OfferApp.fromMap(offer));
    }
    pubsList.forEach((OfferApp offer) {
      this.widget.fields.forEach((String field) {
        List<String> contentToSearch = offer
            .toJSON()[field.toLowerCase()]
            .toString()
            .toLowerCase()
            .split(' ');
        if (contentToSearch.contains(this.widget.keyword)) {
          filteredPubList.add(offer);
        }
      });
    });
    return filteredPubList;
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.keyword != ' ') {
      return FutureBuilder<List<OfferApp>>(
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
                                for (OfferApp offer in snapshot.data.reversed)
                                  new OfferSection(offer),
                              ],
                            )))),
              );
            } else {
              initializeListAndUser();
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
      return Scaffold(
          body: Center(
              child: Text(
        'Search Offers Screen',
        style: TextStyle(fontSize: 21),
      )));
    }
  }
}
