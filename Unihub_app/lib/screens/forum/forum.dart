import 'dart:convert';
import 'package:unihub_app/i18N/appTranslations.dart';
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
                  title: Text(AppLocalizations.instance.text("offer_title")),
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
                    Navigator.of(context).pushNamed('/addOffer')
                      ..then((result) {
                        setState(() {
                          print(result);
                          snapshot.data.add(result);
                        });
                      });
                  },
                ));
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text(AppLocalizations.instance.text("offer_title")),
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
                    Navigator.of(context).pushNamed('/addOffer')
                      ..then((result) {
                        setState(() {
                          print(result);
                          snapshot.data.add(result);
                        });
                      });
                  },
                ));
          }
        });
  }
}
