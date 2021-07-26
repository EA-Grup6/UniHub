import '../networking/apibasehelper.dart';

ApiBaseHelper _helper = ApiBaseHelper();

class RegisterController {
  Future<dynamic> registerUser(
      String username, String password, bool isGoogleAcount) async {
    var body = {'username': username, 'password': password};
    print(body);
    final response = await _helper.post('/User/newUser/$isGoogleAcount', body);
    return response;
  }
}
