import 'dart:convert';
import 'package:unihub_app/screens/gmaps/gmaps.dart';
import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/offer_controller.dart';
import 'package:unihub_app/models/offer.dart';
import '../../widgets/offerSection.dart';
import 'package:http/http.dart' as http;

class ForumScreen extends StatefulWidget {
  Forum createState() => Forum();
}

class Forum extends State<ForumScreen> {
  @override
  void initState() {
    getOffers();
    //Aquí se llama a la API cuando cargamos esta vista
    super.initState();
  }

  Future<List<OfferApp>> getOffers() async {
    http.Response response = await OfferController().getOffers();
    List<OfferApp> preListOffers = [];
    for (var offer in jsonDecode(response.body)) {
      preListOffers.add(OfferApp.fromMap(offer));
    }
    return preListOffers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OfferApp>>(
        future: getOffers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Academic offering"),
                ),
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
                floatingActionButton: FloatingActionButton(
                  heroTag: "btnAddOffer",
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/addOffer');
                  },
                ));
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Feed"),
                ),
                body: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  heroTag: "btnAddOffer",
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/addOffer');
                  },
                ));
          }
        });
  }
}

class DataSearch extends SearchDelegate<String> {
  final subjects = [
    "EA",
    "MF",
    "AERO",
    "MV",
    "ITA",
    "MGTA",
    "DSA",
    "XLAM",
    "ALGEBRA",
    "AMPLI1",
    "AMPLI2",
    "PDS",
    "INFO2",
    "SX",
    "TIQ",
    "CSD",
  ];

  final recentSubjects = [
    "INFO2",
    "SX",
    "TIQ",
    "CSD",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some results based on the selection
    return Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(query),
          ),
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final subjectsList = query.isEmpty
        ? recentSubjects
        : subjects.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.subject),
        title: RichText(
          text: TextSpan(
              text: subjectsList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: subjectsList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: subjectsList.length,
    );
  }
}
