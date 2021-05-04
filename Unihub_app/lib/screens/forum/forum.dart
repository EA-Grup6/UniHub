import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  Forum createState() => Forum();
}

class Forum extends State<ForumScreen> {
  
  final TextStyle _titleController = TextStyle();
  final TextStyle _universityController = TextStyle();
  final TextStyle _usernameController = TextStyle();
  final TextStyle _descriptionController = TextStyle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Academic offering"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            })
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Form(
                  
            ))));
  }
}

class DataSearch extends SearchDelegate<String>{

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
          onPressed: (){
            query = "";
        })
      ];
      throw UnimplementedError();
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ), onPressed: (){
        close(context, null);
      });
      throw UnimplementedError();
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
      throw UnimplementedError();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      final subjectsList = query.isEmpty ? recentSubjects : subjects.where((p) => p.startsWith(query)).toList();

      return ListView.builder(itemBuilder: (context,index)=>ListTile(
        onTap: (){
            showResults(context);
        },
        leading: Icon(Icons.subject),
        title: RichText(text: TextSpan(
          text: subjectsList[index].substring(0,query.length),
          style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: [TextSpan(
            text: subjectsList[index].substring(query.length),
            style: 
                TextStyle(color: Colors.grey))
            ]),
          ),
        ),
        itemCount: subjectsList.length,
      );
      
      throw UnimplementedError();
  }
}
