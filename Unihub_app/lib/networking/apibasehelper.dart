import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:unihub_app/networking/api_exceptions.dart';
import 'dart:async';
import 'api_exceptions.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://10.0.2.2:4000";

  Future<dynamic> post(String url, dynamic content) async {
    print('Api Post, url $url');
    Map<String, String> customHeaders = {'content-type': 'application/json'};
    var bodyF = jsonEncode(content);
    var finalResponse;
    try {
      print('Content: ' + content.toString());
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: customHeaders, body: bodyF);
      finalResponse = response;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post recieved!');
    return finalResponse;
  }

  Future<dynamic> get(String url) async {
    print('Api get, url $url');
    Map<String, String> customHeaders = {'content-type': 'application/json'};
    var finalResponse;
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + url), headers: customHeaders);
      finalResponse = response;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get received!');
    return finalResponse;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');
    var finalResponse;
    try {
      final response = await http.delete(Uri.parse(_baseUrl + url));
      finalResponse = response;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete received!');
    return finalResponse;
  }

  dynamic _returnResponse(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print('200 Received');
        return response.statusCode;
      case 201:
        print('201 Received');
        return response.statusCode;
      //throw BadRequestException(json.decode(response.body.toString()));
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
