import 'dart:convert';

import 'package:unihub_app/models/user.dart';

import '../networking/apibasehelper.dart';
import 'package:http/http.dart' as http;

ApiBaseHelper _helper = ApiBaseHelper();

class EditProfileController {
  Future<dynamic> loginUser(String username, String password) async {
    var body = {'username': username, 'password': password};
    print(body);
    final http.Response response = await _helper.post('/User/loginUser', body);
    print("Estoy en response: " + response.body);
    return response;
  }

  Future<dynamic> getProfile(String username) async {
    final http.Response response = await _helper.get('/User/getUser/$username');
    print("Response: " + response.body);
    return response.body;
  }

  Future<dynamic> updateProfile(UserApp user) async {
    print(user);
    var json = user.toJSON();
    print(json);
    final http.Response response = await _helper.post('/User/updateUser', json);
    print("Estoy en response: " + response.body);
    return response.body;
  }
}
