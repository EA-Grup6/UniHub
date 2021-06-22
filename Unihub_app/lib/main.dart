import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihub_app/app.dart';
import 'package:unihub_app/theming/themeModel.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeModel>(
      create: (BuildContext context) => ThemeModel(),
      child: App(),
    ),
  );
}
