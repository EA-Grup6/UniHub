import 'package:flutter/material.dart';
import 'package:unihub_app/screens/jitsi/jitsiScreen.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class OfferSection extends StatelessWidget {
  final String _id;
  final String _username;
  final String _university;
  final String _subject;
  final String _title;
  final String _content;
  final List<dynamic> _likes;
  final String _price;
  //final int buys;

  OfferSection(this._id, this._title, this._university, this._subject,
      this._username, this._content, this._likes, this._price);

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
          ),
          contentPadding: EdgeInsets.all(0),
          title: Text(_title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_university + ' - ' + _username),
              Text(_content),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.whatshot_rounded,
                        color: this._likes.length > 50
                            ? (this._likes.length > 100
                                ? Colors.red
                                : Colors.orange)
                            : Colors.green),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Text(_likes.length.toString()),
                  ),
                  Icon(Icons.euro, color: Colors.green),
                  Expanded(
                    child: Text(_price),
                  )
                ],
              ),
            ],
          ),
          onTap: () {
            _joinMeeting();
          }, //Ver perfil del usuario
        ));
  }

  _joinMeeting() async {
    try {
      var options = JitsiMeetingOptions(room: this._id)
        ..subject = this._subject
        ..audioOnly = false
        ..audioMuted = true
        ..videoMuted = true
        ..webOptions = {"enableWelcomePage": false};

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
