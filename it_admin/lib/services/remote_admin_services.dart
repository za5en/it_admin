import 'package:http/http.dart' as http;
import 'api_client.dart';

class RemoteAdminServices {
  const RemoteAdminServices();
  final _apiClient = const ApiClient();

  Future<http.Response> getInfo(String userId, String password) async {
    var response = await _apiClient.getRequest(
      path: '/user/getInfo/?user_id=$userId&password=$password',
    );
    return response;
  }
}
