import 'package:flutter/material.dart';
import '../forum/forum.dart';
import '../profile/profile.dart';
import '../feed/feed.dart';

class HomepageScreen extends StatefulWidget {
  Homepage createState() => Homepage();
}

class Homepage extends State<HomepageScreen> {
  int currentTab = 0;
  final List<Widget> screens = [
    FeedScreen(),
    //  Chat(),
    // Search()
    ProfileScreen()
  ];
  //
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = FeedScreen();

  @override
  Widget build(BuildContext context) {
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = FeedScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color:
                              currentTab == 0 ? Colors.blue : Colors.grey[300],
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: currentTab == 0
                                ? Colors.blue
                                : Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        //currentScreen =0;
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color:
                              currentTab == 1 ? Colors.blue : Colors.grey[300],
                        ),
                        Text(
                          "Search",
                          style: TextStyle(
                            color: currentTab == 1
                                ? Colors.blue
                                : Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      //currentScreen = ;
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: currentTab == 2 ? Colors.blue : Colors.grey[300],
                      ),
                      Text(
                        "Chat",
                        style: TextStyle(
                          color:
                              currentTab == 2 ? Colors.blue : Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = ProfileScreen();
                      currentTab = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outlined,
                        color: currentTab == 3 ? Colors.blue : Colors.grey[300],
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          color:
                              currentTab == 3 ? Colors.blue : Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
