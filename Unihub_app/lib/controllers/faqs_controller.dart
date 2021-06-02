import 'package:unihub_app/models/faqs.dart';

import '../networking/apibasehelper.dart';
import 'package:http/http.dart' as http;

ApiBaseHelper _helper = ApiBaseHelper();

class FaqsController {
    Future<dynamic> getFaqs() async {
    final http.Response response = await _helper.get('/Faqs');
    print("Response: " + response.body);
    return response;
  }

}