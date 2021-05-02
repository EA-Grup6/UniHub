import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:unihub_app/routes/api_exceptions.dart';
import 'dart:async';

class ApiBaseHelper {
  final String _baseUrl = "http://10.0.2.2:4000";

  Future<dynamic> post(String url, dynamic content) async {
    print('Api Post, url $url');
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: content);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post recieved!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      //Falta poner nuestros códigos de error
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        print('200 Received');
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
