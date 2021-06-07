import '../networking/apibasehelper.dart';

ApiBaseHelper _helper = ApiBaseHelper();

class SocialController {
  Future<dynamic> follow(String username, String password) async {
    var body = {'username': username, 'password': password};
    print(body);
    final response = await _helper.post('/User/newUser', body);
    return response;
  }

  Future<dynamic> unfollow(String username, String password) async {
    var body = {'username': username, 'password': password};
    print(body);
    final response = await _helper.post('/User/newUser', body);
    return response;
  }
}
