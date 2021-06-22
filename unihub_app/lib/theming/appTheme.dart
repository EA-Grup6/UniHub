import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Light Theme
  static final ThemeData lightTheme = ThemeData.light();

  // Dark Theme
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.black),
      backgroundColor: Colors.black,
      dialogBackgroundColor: Colors.grey[900],
      dialogTheme: DialogTheme(backgroundColor: Colors.grey[800]),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.blue),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blue[300],
      ));
}
