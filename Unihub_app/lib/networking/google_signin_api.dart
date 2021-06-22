import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GoogleSignInApi {
  static final _clientIDWeb =
      '610597929696-efo8if73qh7g34ee3cs8f5bs7qgej9da.apps.googleusercontent.com';
  static final _clientId =
      '610597929696-8917pe1bv6juog57a51npt71rjkn9o30.apps.googleusercontent.com';

  static final _googleSignIn =
      GoogleSignIn(clientId: kIsWeb ? _clientIDWeb : null);

  static Future<GoogleSignInAccount> login() => _googleSignIn.signIn();
}
