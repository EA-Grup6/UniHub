import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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
  String username;
  List<OfferApp> offersList;
  @override
  void initState() {
    getUsername();
    //Aquí se llama a la API cuando cargamos esta vista
    super.initState();
  }

  getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.username = prefs.getString('username');
    });
    return this.username;
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
                    child: RefreshIndicator(
                        child: ListView.builder(
                            padding: EdgeInsets.all(10),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              this.offersList = new List<OfferApp>.from(
                                  snapshot.data.reversed);
                              if (snapshot.data.reversed
                                      .elementAt(index)
                                      .username ==
                                  this.username) {
                                return new Dismissible(
                                    key: ObjectKey(
                                        this.offersList.elementAt(index)),
                                    child: new OfferSection(
                                        this.offersList.elementAt(index)),
                                    confirmDismiss: (direction) {
                                      return showDeleteOfferAlertDialog(
                                          context, index);
                                    });
                              } else {
                                return new OfferSection(
                                    this.offersList.elementAt(index));
                              }
                            }),
                        onRefresh: () async {
                          setState(() {});
                        })),
                floatingActionButton: FloatingActionButton(
                  heroTag: "btnAddOffer",
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/addOffer').then((result) {
                      setState(() {
                        if (result != null) snapshot.data.add(result);
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

  showDeleteOfferAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget submitButton = TextButton(
      child: Text(AppLocalizations.instance.text("yes")),
      onPressed: () async {
        //delete post
        await OfferController()
            .deleteOffer(this.offersList.elementAt(index).id)
            .whenComplete(() {
          setState(() {
            this.offersList.removeAt(index);
          });
          Navigator.pop(context);
        });
      },
    );
    Widget dismissButton = TextButton(
      child: Text(AppLocalizations.instance.text("no")),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        content:
            Text(AppLocalizations.instance.text("feed_deletePostConfirmation")),
        actions: [dismissButton, submitButton]);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
