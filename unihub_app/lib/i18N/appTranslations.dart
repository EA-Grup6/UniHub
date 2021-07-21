import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  static final AppLocalizations _singleton = new AppLocalizations._internal();
  AppLocalizations._internal();
  static AppLocalizations get instance => _singleton;

  Map<dynamic, dynamic> _localisedValues;

  Future<AppLocalizations> load(Locale locale) async {
    String jsonContent = await rootBundle
        .loadString("assets/i18N/localization_${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return this;
  }

  String text(String key, Map<String, dynamic> args) {
    String value = _localisedValues[key] ?? "$key not found";
    if (args != null) {
      for (final key in args.keys) {
        value = value.replaceAll('{$key}', '${args[key]}');
      }
    }
    return value;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es', 'ca'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.instance.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}
