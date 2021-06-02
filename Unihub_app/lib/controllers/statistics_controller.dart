import '../networking/apibasehelper.dart';

ApiBaseHelper _helper = ApiBaseHelper();

class StadisticsController {
  Future<dynamic> getStadistics() async {
    final response = await _helper.get('/Statistics/get');
    print(response.body);
    return response.body;
  }
}
