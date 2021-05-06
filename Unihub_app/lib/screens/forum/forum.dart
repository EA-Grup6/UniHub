import 'package:flutter/material.dart';

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
      body: ListView.separated(
        padding: EdgeInsets.all(10),
        separatorBuilder: (BuildContext context, int index) {
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Divider(),
            ),
          );
        },
        itemCount: 3, // numero de posts (request a la api y tal...),
        itemBuilder: (BuildContext context, int index) {
          // Map post = post[index];
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/unihubLogo.png'),
                  radius: 25,
                ),
                contentPadding: EdgeInsets.all(0),
                title: Text('Doy clases de AERO'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('UPC, EETAC - Pol Casaña'),
                    Text('Si quieres plantarle cara al Rojas, ven conmigo'),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.recommend,
                          color: Colors.blue,
                        ),
                        Expanded(
                          child: Text('6'),
                        ),
                        Icon(
                          Icons.euro,
                          color: Colors.green,
                        ),
                        Expanded(
                          child: Text('10€/h'),
                        )
                      ],
                    ),
                  ],
                ),
                onTap: () {}, //Ver perfil del usuario
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btnAddOffer",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/addOffer');
        },
      ),
    );
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
