import '../networking/apibasehelper.dart';

ApiBaseHelper _helper = ApiBaseHelper();

class LoginController {
  Future<dynamic> loginUser(String username, String password) async {
    var body = {'username': username, 'password': password};
    print(body);
    final response = await _helper.post('/User/loginUser', body);
    return response;
  }
}
