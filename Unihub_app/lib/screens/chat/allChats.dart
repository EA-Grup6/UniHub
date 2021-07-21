import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/controllers/editProfile_controller.dart';
import 'package:unihub_app/i18N/appTranslations.dart';

import './chatPage.dart';
import '../../models/user.dart';
import '../../controllers/chat_controller.dart';

class AllChatsScreen extends StatefulWidget {
  AllChatsScreen({this.chatController});
  @override
  _AllChatsScreenState createState() => _AllChatsScreenState();
  final ChatController chatController;
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  String myUsername;
  @override
  void initState() {
    super.initState();
  }

  void friendClicked(String friend) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ChatPage(this.widget.chatController, friend, myUsername);
        },
      ),
    );
  }

  Widget buildAllChatList() {
    return FutureBuilder<List<String>>(
        future: getFriends(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                String friend = snapshot.data[index];
                return ListTile(
                  title: Text(friend),
                  onTap: () => friendClicked(friend),
                );
              },
            );
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ]);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.instance.text("chat_allChats", null)),
      ),
      body: buildAllChatList(),
    );
  }

  Future<List<String>> getFriends() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.myUsername = prefs.getString('username');
    UserApp currentUser = UserApp.fromMap(
        jsonDecode(await EditProfileController().getProfile(myUsername)));
    List<String> listFriends = [];
    currentUser.followers.forEach((element) {
      listFriends.add(element);
    });
    currentUser.following.forEach((element) {
      if (!listFriends.contains(element)) {
        listFriends.add(element);
      }
      ;
    });
    return listFriends;
  }
}
