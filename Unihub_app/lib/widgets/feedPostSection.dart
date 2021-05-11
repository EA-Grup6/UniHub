import 'package:flutter/material.dart';

class FeedPostSection extends StatelessWidget {
  Image _image;
  final String _username;
  final String _content;
  final List<dynamic> _likes;
  final List<dynamic> _comments;

  FeedPostSection(this._username, this._content, this._likes, this._comments);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[200], width: 1))),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: ListTile(
          leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/unihubLogo.png'),
              radius: 25,
              child: IconButton(
                  splashRadius: 25,
                  icon: Icon(Icons.voicemail_rounded,
                      color: Colors.transparent, size: 30),
                  onPressed: () {})),
          //Te tiene que llevar al perfil del usuario
          contentPadding: EdgeInsets.all(0),
          title: Text(this._username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              )),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              child: Text(this._content),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.favorite_outline_rounded),
                      alignment: Alignment.center,
                      onPressed: () {
                        //Tiene que añadir tu _id a la lista de likes del post
                      }),
                  IconButton(
                      icon: Icon(Icons.messenger_outline_rounded),
                      alignment: Alignment.center,
                      onPressed: () {
                        //Te tiene que llevar a los comentarios
                      }),
                  IconButton(
                      icon: Icon(Icons.share_outlined),
                      alignment: Alignment.center,
                      onPressed: () {
                        //Te tiene que llevar al dialogo para compartir el
                      })
                ])
          ])),
    );
  }
}
