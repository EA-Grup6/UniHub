import '../networking/apibasehelper.dart';
import 'package:http/http.dart' as http;

ApiBaseHelper _helper = ApiBaseHelper();

class CommentController {
  Future<dynamic> addComment(
      String username, String content, String date, String feedId) async {
    var body = {
      'feedId': feedId,
      'username': username,
      'content': content,
      'publicationDate': date
    };
    final http.Response response =
        await _helper.post('/Comment/newComment/$feedId', body);
    print("Estoy en response " + response.body);
    return response;
  }

  Future<dynamic> getComments(String feedId) async {
    final http.Response response =
        await _helper.get('/Comment/getComments/$feedId');
    print('Response: ' + response.body);
    return response;
  }

  Future<dynamic> deleteComment(String id) async {
    final http.Response response =
        await _helper.delete('/Comment/deleteComment/$id');
    print('Response: ' + response.body);
    return response;
  }

  Future<dynamic> getUserImage(String username) async {
    final http.Response response =
        await _helper.get('/User/getUserImage/$username');
    return response.body;
  }

  Future<dynamic> setLikes(String username, String action, String id) async {
    var body = {'username': username, '_id': id};
    final http.Response response =
        await _helper.post('/Comment/updateLikes/$action', body);
    return response.statusCode;
  }
}
