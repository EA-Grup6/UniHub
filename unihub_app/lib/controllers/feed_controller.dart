import '../networking/apibasehelper.dart';
import 'package:http/http.dart' as http;

ApiBaseHelper _helper = ApiBaseHelper();

class FeedController {
  Future<dynamic> createFeedPub(String username, String content) async {
    var body = {'username': username, 'content': content};
    print(body);
    final http.Response response = await _helper.post('/Feed/newFeed', body);
    print("Estoy en response " + response.body);
    return response.statusCode;
  }

  Future<dynamic> getFeedPubs() async {
    final http.Response response = await _helper.get('/Feed/getAllFeeds');
    print("Response: " + response.body);
    return response;
  }
}
