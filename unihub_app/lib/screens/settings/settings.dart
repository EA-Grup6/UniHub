import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  Settings createState() => Settings();
}

class Settings extends State<SettingsScreen> {
  String languageCode;
  bool isPrivate;
  bool isThemeDark;
  String language;
  List<String> availableLanguages = ['System', 'Spanish', 'Catalan', 'English'];
  Map<String, String> mapLanguages = {
    'Spanish': 'es',
    'Catalan': 'ca',
    'English': 'en'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Settings')),
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text('Private account'),
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
                  Text('Dark theme'),
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
                  Text('Language'),
                  DropdownButton<String>(
                    isExpanded: false,
                    value: language,
                    hint: Text('Language'),
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
                        if (language == 'System') {
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
    /*
            child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Private account'),
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dark theme'),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Language'),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: language,
                    hint: Text('Degree'),
                    items: availableLanguages.map((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (String e) async {
                      setState(() {
                        language = e;
                        setLanguage(language);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        )));*/
  }

  setLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', language);
    print(prefs.getString('lang'));
  }
}
