import 'package:flutter/material.dart';
import 'i18N/appTranslations.dart';
import 'screens/addOffer/addOffer.dart';
import 'screens/editProfile/editProfile.dart';
import 'screens/splash/splash.dart';
import 'screens/homepage/homepage.dart';
import 'screens/login/login.dart';
import 'screens/register/register.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('ca', ''),
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/login': (BuildContext context) => LoginScreen(),
        '/register': (BuildContext context) => RegisterScreen(),
        '/editProfile': (BuildContext context) => EditProfileScreen(),
        '/homepage': (BuildContext context) => HomepageScreen(),
        '/addOffer': (BuildContext context) => AddOfferScreen(),
      },
    );
  }
}
