import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:unihub_app/app.dart' as myApp;

class SettingsScreen extends StatefulWidget {
  @override
  Settings createState() => Settings();
}

class Settings extends State<SettingsScreen> {
  String languageCode;
  bool isPrivate;
  bool isThemeDark;
  String language;
  List<String> availableLanguages = [
    AppLocalizations.instance.text("language_system"),
    AppLocalizations.instance.text("language_spanish"),
    AppLocalizations.instance.text("language_catalan"),
    AppLocalizations.instance.text("language_english")
  ];
  Map<String, String> mapLanguages = {
    AppLocalizations.instance.text("language_spanish"): 'es',
    AppLocalizations.instance.text("language_catalan"): 'ca',
    AppLocalizations.instance.text("language_english"): 'en'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                Text(AppLocalizations.instance.text("settings_titleScreen"))),
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(AppLocalizations.instance.text("settings_privateAccount")),
                Switch(
                  value: isPrivate,
                  onChanged: (value) {
                    setState(() {
                      isPrivate = value;
                      print(isPrivate);
                    });
                  },
                  activeTrackColor: Colors.lightBlueAccent,
                  activeColor: Colors.blue,
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(AppLocalizations.instance.text("settings_darkTheme")),
                  Switch(
                    value: isThemeDark,
                    onChanged: (value) {
                      setState(() {
                        isThemeDark = value;
                        print(isThemeDark);
                      });
                    },
                    activeTrackColor: Colors.lightBlueAccent,
                    activeColor: Colors.blue,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(AppLocalizations.instance.text("settings_language")),
                  DropdownButton<String>(
                    isExpanded: false,
                    value: language,
                    hint: Text("Selecciona un " +
                        AppLocalizations.instance
                            .text("settings_language")
                            .toLowerCase()),
                    items: availableLanguages.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (String e) async {
                      setState(() {
                        Locale myLocale = Localizations.localeOf(context);
                        language = e;
                        if (language ==
                            AppLocalizations.instance.text("language_system")) {
                          languageCode = myLocale.languageCode.toString();
                        } else {
                          languageCode = mapLanguages[language].toString();
                        }
                        setLanguage(languageCode);
                      });
                    },
                  ),
                ],
              )
            ]))));
  }

  setLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', language);
    AppLocalizations.instance.load(Locale(languageCode, ''));
  }
}
