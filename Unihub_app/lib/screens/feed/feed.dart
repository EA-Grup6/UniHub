import 'package:flutter/material.dart';
import 'package:unihub_app/widgets/feedPostSection.dart';

class FeedScreen extends StatefulWidget {
  Feed createState() => Feed();
}

class Feed extends State<FeedScreen> {
  List<String> listaContenidos = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Sample text.',
    'Esto es una prueba de una sola linea',
    'Esto es relleno',
    'Esto es mas relleno',
    'Estoy hasta los cojones del relleno'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Feed"),
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
                          new FeedPostSection("Fullname of the user", contenido,
                              ["", ""], ["", ""]),
                      ],
                    )))),
        floatingActionButton: FloatingActionButton(
          heroTag: "btnAddFeed",
          child: Icon(Icons.add),
          onPressed: () {
            showAlertDialog(context);
          },
        ));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget submitButton = TextButton(
      child: Text("Create new post"),
      onPressed: () async {
        //Submit post
        Navigator.pop(context);
      },
    );
    Widget dismissButton = TextButton(
      child: Text("Discard post"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        content: TextFormField(
          keyboardType: TextInputType.multiline,
          minLines: 4,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: 'New post',
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
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
