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

  List<String> availableLanguages = ['system', 'spanish', 'catalan', 'english'];
  Map<String, String> mapLanguages = {
    'spanish': 'es',
    'catalan': 'ca',
    'english': 'en'
  };

  @override
  void initState() {
    getLanguage();
    super.initState();
  }

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
                    hint: Text(
                        AppLocalizations.instance.text("settings_select") +
                            " " +
                            AppLocalizations.instance
                                .text("settings_language")
                                .toLowerCase()),
                    items: availableLanguages.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(
                            AppLocalizations.instance.text("language_" + e)),
                      );
                    }).toList(),
                    onChanged: (String e) async {
                      setState(() {
                        Locale myLocale = Localizations.localeOf(context);
                        language = e;
                        print(language);
                        if (language == "system") {
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
    await AppLocalizations.instance.load(Locale(languageCode, ''));
  }

  getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.languageCode = prefs.getString('lang');
    mapLanguages.forEach((key, value) {
      if (value == this.languageCode) {
        this.language = key;
      }
    });
    print(this.language);
  }
}
