import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/chat_controller.dart';
import 'package:unihub_app/controllers/editProfile_controller.dart';
import 'package:unihub_app/controllers/feed_controller.dart';
import 'package:unihub_app/controllers/login_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/models/feedPublication.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/screens/homepage/homepage.dart';
import 'package:unihub_app/screens/login/login.dart';
import 'package:http/http.dart' as http;

String finalUsername;
String languageCode;

class SplashScreen extends StatefulWidget {
  Splash createState() => Splash();
}

createToast(String message, Color color) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<List<FeedPublication>> getAllFeeds() async {
  http.Response response = await FeedController().getFeedPubs();
  List<FeedPublication> preFeedList = [];
  for (var feedPub in jsonDecode(response.body)) {
    preFeedList.add(FeedPublication.fromMap(feedPub));
  }
  return preFeedList;
}

class Splash extends State<SplashScreen> {
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      UserApp currentUser;
      ChatController chatController;
      Timer(Duration(seconds: 2), () async {
        if (finalUsername == null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        } else {
          if (await LoginController().checkToken()) {
            currentUser = UserApp.fromMap(jsonDecode(
                await EditProfileController().getProfile(finalUsername)));
            chatController = new ChatController(currentUser.username);
            chatController.init();
            List<FeedPublication> pubsList = await getAllFeeds();
            print(pubsList.length);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomepageScreen(currentUser, chatController, pubsList),
                ));
            if (languageCode != null) {
              await AppLocalizations.instance.load(Locale(languageCode, ''));
            }
            createToast(
                AppLocalizations.instance.text("login_welcomeBack", null) +
                    finalUsername,
                Colors.green);
          } else {
            createToast(AppLocalizations.instance.text("login_authError", null),
                Colors.green);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        }
      });
    });
    super.initState();
  }

  Future getValidationData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var username = preferences.getString('username');
    try {
      var token = preferences.getString('jwt');
      if (token != null) {
        setState(() {
          finalUsername = username;
          languageCode = preferences.getString('lang');
        });
      }
    } catch (exception) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/unihubLogo.png',
                    height: 400, width: 400),
              ],
            )));
  }
}
