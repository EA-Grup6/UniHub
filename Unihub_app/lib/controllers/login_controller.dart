import '../networking/apibasehelper.dart';
import 'package:http/http.dart' as http;

ApiBaseHelper _helper = ApiBaseHelper();

class LoginController {
  Future<dynamic> loginUser(String username, String password) async {
    var body = {'username': username, 'password': password};
    print(body);
    final http.Response response = await _helper.post('/User/loginUser', body);
    print("Estoy en response " + response.toString());
    return response;
  }
}
