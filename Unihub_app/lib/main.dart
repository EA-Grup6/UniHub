import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihub_app/app.dart';
import 'package:unihub_app/models/feedPublication.dart';
import 'package:unihub_app/theming/themeModel.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeModel>(
        create: (BuildContext context) => ThemeModel(),
      ),
      ChangeNotifierProvider<ListFeedPublication>(
          // initialized CustomerList constructor with default 1 value.
          create: (BuildContext context) => ListFeedPublication())
    ],
    child: App(),
  ));
}
