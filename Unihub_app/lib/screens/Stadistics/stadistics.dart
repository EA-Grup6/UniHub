import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/statistics_controller.dart';

import 'package:unihub_app/widgets/textSection.dart';

class StadisticsScreen extends StatefulWidget {
  Stadistics createState() => Stadistics();
}

class Stadistics extends State<StadisticsScreen> {
  String numUsers;
  String numOffers;
  String numPosts;

  Future<List<String>> getStadistics() async {
    List<String> stadistics = [];
    numPosts =
        jsonDecode(await StadisticsController().getStadistics())["numFeeds"];
    stadistics.add(numPosts);
    numUsers =
        jsonDecode(await StadisticsController().getStadistics())["numUsers"];
    stadistics.add(numUsers);
    numOffers =
        jsonDecode(await StadisticsController().getStadistics())["numOffers"];
    stadistics.add(numOffers);
    print(stadistics.toString());
    return stadistics;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: getStadistics(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("App stadistics"),
                ),
                body: SafeArea(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: ListView(children: [
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                              child: Stack(children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextSection("Numero de Usuarios Registrados",
                                    snapshot.data[1]),
                                TextSection("Numero de ofertas realizados",
                                    snapshot.data[2]),
                                TextSection(
                                    "Numero de Posts en el feed realizados",
                                    snapshot.data[0]),
                              ],
                            ),
                          ]))
                        ]))));
          } else {
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
  }
}
