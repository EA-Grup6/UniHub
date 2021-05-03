import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  Home createState() => Home();
}

class Home extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "home Screen",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
