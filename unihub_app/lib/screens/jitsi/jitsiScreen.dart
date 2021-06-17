import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:unihub_app/models/user.dart';

class JitsiScreen extends StatefulWidget {
  final String room;
  final String subject;
  final UserApp user;
  JitsiScreen(this.room, this.subject, this.user);
  JitsiState createState() => JitsiState();
}

class JitsiState extends State<JitsiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: _joinMeeting(), child: Text('Prueba Jitsi')),
              ],
            )));
  }

  _joinMeeting() async {
    try {
      var options = JitsiMeetingOptions(room: this.widget.room)
        ..subject = this.widget.subject
        ..userDisplayName = this.widget.user.fullname
        ..userEmail = this.widget.user.username
        ..userAvatarURL = this.widget.user.profilePhoto // or .png
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
