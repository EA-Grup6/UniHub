import 'package:flutter/material.dart';
import 'package:unihub_app/screens/profile/editingProfile.dart';
import 'package:unihub_app/screens/splash/splash.dart';
import 'screens/homepage/homepage.dart';
import 'screens/login/login.dart';
import 'screens/login/register.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        '/login': (BuildContext context) => LoginScreen(),
        '/register': (BuildContext context) => RegisterScreen(),
        '/editProfile': (BuildContext context) => EditingProfileScreen(),
        '/homepage': (BuildContext context) => HomepageScreen(),
      },
    );
  }
}