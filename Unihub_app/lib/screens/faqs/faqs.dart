import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/faqs_controller.dart';
import 'package:unihub_app/models/faqs.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class FaqsScreen extends StatefulWidget {
  FaqsScreens createState() => FaqsScreens();
}

class FaqsScreens extends State<FaqsScreen> {
  List<Faqs> faqsList;

    @override
  void initState() {
    getFaqs();
    //Aquí se llama a la API cuando cargamos esta vista
    super.initState();
  }

  Future<List<Faqs>> getFaqs() async {
    http.Response response = await FaqsController().getFaqs();
    List<Faqs> preFaqsList = [];
    for (var faqs in jsonDecode(response.body)) {
      preFaqsList.add(Faqs.fromMap(faqs));
    }
    return preFaqsList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Faqs>>(
      future: getFaqs(),
      builder: (context, snapshot) {
          return Scaffold(
              appBar: AppBar(
                title: Text("FAQS"),
              ),
              body: SafeArea(
                  child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {

                        this.faqsList = new List<Faqs>.from(
                            snapshot.data.reversed);
                        return new Card(
                              child: new ListTile(
                                title: new Text(
                                  this.faqsList.elementAt(index).question,
                                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                                ),
                                subtitle: new Text(
                                  this.faqsList.elementAt(index).answer,
                                  style: TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                                ),
                              ),
                        );
                      }),
              ));

      },
    );
  }







}