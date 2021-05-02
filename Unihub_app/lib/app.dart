import 'package:flutter/material.dart';
import 'screens/login/login.dart';
import 'screens/login/register.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      routes: {
        '/register' : (BuildContext context)=>RegisterScreen(),
      },
    );
  }
}
