import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unihub_app/controllers/chat_controller.dart';
import 'package:unihub_app/controllers/feed_controller.dart';
import 'package:unihub_app/models/feedPublication.dart';
import 'package:unihub_app/models/user.dart';
import 'package:unihub_app/screens/chat/allChats.dart';
import 'package:unihub_app/screens/profile/Profile.dart';
import '../forum/forum.dart';
import '../feed/feed.dart';
import '../search/search.dart';
import 'package:http/http.dart' as http;

class HomepageScreen extends StatefulWidget {
  //TODO crear el Socket de los chats (tambien notificará cambios en el perfil)
  HomepageScreen(this.user, this.chatController, this.pubsList);
  UserApp user;
  ChatController chatController;
  List<FeedPublication> pubsList;
  Homepage createState() => Homepage();
}

class Homepage extends State<HomepageScreen> {
  List<FeedPublication> feedList;
  int currentTab = 0;
  final List<Widget> screens = [
    FeedScreen(),
    AllChatsScreen(),
    SearchScreen(),
    ProfileScreen()
  ];
  //

  Future<List<FeedPublication>> getAllFeeds() async {
    http.Response response = await FeedController().getFeedPubs();
    List<FeedPublication> preFeedList = [];
    for (var feedPub in jsonDecode(response.body)) {
      preFeedList.add(FeedPublication.fromMap(feedPub));
    }
    return preFeedList;
  }

  Widget currentScreen;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    if (currentScreen == null) {
      currentScreen = FeedScreen(pubsList: this.widget.pubsList);
    }
    return Scaffold(
      body: SafeArea(
          child: PageStorage(
        child: currentScreen,
        bucket: bucket,
      )),
      floatingActionButton: FloatingActionButton(
        heroTag: "btnOffers",
        child: Icon(Icons.menu_book_outlined),
        elevation: currentTab == 4 ? 15.0 : 0.0,
        onPressed: () {
          setState(() {
            currentScreen = ForumScreen();
            currentTab = 4;
          });
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 0.2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                  minWidth: 50,
                  onPressed: () async {
                    setState(() {
                      currentScreen =
                          FeedScreen(pubsList: this.widget.pubsList);
                      currentTab = 0;
                    });
                  },
                  child: Icon(
                    Icons.home_outlined,
                    color: currentTab == 0 ? Colors.blue : Colors.grey[400],
                  )),
              MaterialButton(
                  minWidth: 50,
                  onPressed: () {
                    setState(() {
                      currentScreen = SearchScreen();
                      currentTab = 1;
                    });
                  },
                  child: Icon(
                    Icons.search,
                    color: currentTab == 1 ? Colors.blue : Colors.grey[400],
                  )),
              MaterialButton(
                  minWidth: 50,
                  onPressed: () {
                    setState(() {
                      currentScreen = AllChatsScreen(
                          chatController: this.widget.chatController);
                      currentTab = 2;
                    });
                  },
                  child: Icon(
                    Icons.chat_bubble_outline,
                    color: currentTab == 2 ? Colors.blue : Colors.grey[400],
                  )),
              MaterialButton(
                  minWidth: 50,
                  onPressed: () {
                    setState(() {
                      currentScreen = ProfileScreen(
                          username: this.widget.user.username,
                          currentUser: this.widget.user);
                      currentTab = 3;
                    });
                  },
                  child: Icon(
                    Icons.person_outlined,
                    color: currentTab == 3 ? Colors.blue : Colors.grey[400],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
