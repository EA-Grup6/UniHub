import '../networking/apibasehelper.dart';

ApiBaseHelper _helper = ApiBaseHelper();

class LoginController {
  Future<String> loginUser(String username, String password) async {
    var body = {'username': username, 'password': password};
    print(body);
    final int response = await _helper.post('/User/loginUser', body);
    print("Estoy en response " + response.toString());
    return response.toString();
  }
}
