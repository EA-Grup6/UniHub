import 'package:flutter/material.dart';
import 'package:unihub_app/widgets/feedPostSection.dart';

class FeedScreen extends StatefulWidget {
  Feed createState() => Feed();
}

class Feed extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Feed"),
          actions: <Widget>[
            //Hay que poder hacer posts
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  //Lanza una alert para hacer el post;
                  showAlertDialog(context);
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
                        FeedPostSection(
                            "_username", "_content", ["", ""], ["", ""]),
                        FeedPostSection(
                            "_username", "_content", ["", ""], ["", ""]),
                        FeedPostSection(
                            "_username", "_content", ["", ""], ["", ""]),
                      ],
                    )))));
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
