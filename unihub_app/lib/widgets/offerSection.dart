import 'package:flutter/material.dart';
import 'package:unihub_app/models/offer.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class OfferSection extends StatelessWidget {
  final OfferApp offer;
  //final int buys;

  OfferSection(this.offer);

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
          title: Text(this.offer.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(this.offer.university + ' - ' + this.offer.username),
              Text(this.offer.description),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.whatshot_rounded,
                        color: this.offer.likes.length > 50
                            ? (this.offer.likes.length > 100
                                ? Colors.red
                                : Colors.orange)
                            : Colors.green),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Text(this.offer.likes.length.toString()),
                  ),
                  Icon(Icons.euro, color: Colors.green),
                  Expanded(
                    child: Text(this.offer.price.toString()),
                  )
                ],
              ),
            ],
          ),
          trailing: this.offer.type == "Online Class"
              ? Icon(Icons.videocam_outlined)
              : Icon(Icons.videocam_off_outlined),
          onTap: () {
            this.offer.type == "Online Class" ? _joinMeeting() : null;
          }, //Ver perfil del usuario
        ));
  }

  _joinMeeting() async {
    try {
      var options = JitsiMeetingOptions(room: this.offer.id)
        ..subject = this.offer.title
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
