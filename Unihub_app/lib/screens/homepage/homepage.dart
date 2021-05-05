import 'package:flutter/material.dart';
import 'package:unihub_app/screens/profile/Profile.dart';
import 'package:unihub_app/screens/forum/forum.dart';

import '../forum/forum.dart';
import 'home.dart';

class HomepageScreen extends StatefulWidget {
  Homepage createState() => Homepage();
}

class Homepage extends State<HomepageScreen> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    //  Chat(),
    // Search()
    ProfileScreen()
  ];
  //
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageStorage(
        child: currentScreen,
        bucket: bucket,
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.menu_book_outlined),
        onPressed: () {
          setState(() {
            currentScreen = ForumScreen();
            currentTab = 0;
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
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.blue,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        //currentScreen = ;
                        //CurrentTab=0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.blue,
                        ),
                        Text(
                          "Search",
                          style: TextStyle(color: Colors.blue),
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
                      //CurrentTab=0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_outlined,
                        color: Colors.blue,
                      ),
                      Text(
                        "Chat",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currentScreen = ProfileScreen();
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outlined,
                        color: Colors.blue,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(color: Colors.blue),
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
