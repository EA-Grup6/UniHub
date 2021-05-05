import 'package:flutter/material.dart';

class FeedPostSection extends StatelessWidget {
  Image _image;
  final String _username;
  final String _content;
  final List<String> _likes;
  final List<String> _comments;

  FeedPostSection(this._username, this._content, this._likes, this._comments);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.grey[200], width: 1))),
        child: Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          child: Image.asset('assets/images/unihubLogo.png'),
                        ))),
                Flexible(
                    flex: 3,
                    child: Container(
                      child: Column(children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Text('Fullname of the User',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            )),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Sample text."),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      icon:
                                          Icon(Icons.favorite_outline_rounded),
                                      alignment: Alignment.center,
                                      onPressed: () {}),
                                  IconButton(
                                      icon:
                                          Icon(Icons.messenger_outline_rounded),
                                      alignment: Alignment.center,
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(Icons.share_outlined),
                                      alignment: Alignment.center,
                                      onPressed: () {})
                                ]))
                      ]),
                    ))
              ],
            )));
  }
}
