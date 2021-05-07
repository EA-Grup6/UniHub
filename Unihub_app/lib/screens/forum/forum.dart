import 'package:flutter/material.dart';

import '../../widgets/offerSection.dart';

class ForumScreen extends StatefulWidget {
  Forum createState() => Forum();
}

class Forum extends State<ForumScreen> {
  Image _image;
  final TextStyle _titleController = TextStyle();
  final TextStyle _universityController = TextStyle();
  final TextStyle _usernameController = TextStyle();
  final TextStyle _descriptionController = TextStyle();
  final TextStyle _statusController = TextStyle();
  final TextStyle _moneyController = TextStyle();

  @override
  void initState() {
    //Aquí se llama a la API cuando cargamos esta vista
    super.initState();
  }

  List<String> listaContenidos = [
    "Ofrezco clases de AERO",
    "Quieres enfrentarte al Minimo 2 de EA? Habla conmigo!"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Academic offering"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (String contenido in listaContenidos)
                          new OfferSection(
                              "Fullname of the user",
                              "UPC, EETAC",
                              "AERO",
                              "Titulo de las ofertas",
                              contenido,
                              ["", ""],
                              "10"),
                      ],
                    )))),
        floatingActionButton: FloatingActionButton(
          heroTag: "btnAddOffer",
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed('/addOffer');
          },
        ));
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
