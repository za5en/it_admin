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

  Future<http.Response> auth() async {
    var response = await _apiClient.getRequest(
      authIp: true,
      path:
          '/realms/assistant-app/protocol/openid-connect/auth?response_type=code&client_id=assistant-app&scope=openid%20profile%20email%20microprofile-jwt&redirect_uri=http%3A%2F%2Flocalhost%3A8000',
    );
    return response;
  }

  Future<http.Response> authPost(
      String login, String password, String path, String cookie) async {
    var response =
        await _apiClient.postAuthRequest(path: path, cookie: cookie, body: {
      'username': login,
      'password': password,
      'credentialId': '',
    });
    return response;
  }

  Future<http.Response> authToken(String code, String uri, String encoded,
      {String? login, String? password}) async {
    var response = await _apiClient.postTokenRequest(
        path: '/realms/assistant-app/protocol/openid-connect/token',
        encoded: encoded,
        body: {
          'grant_type': 'password', //'authorization_code',
          'client_id': 'assistant-app', //temp
          'username': login ?? '',
          'password': password ?? '',
          //'code': code,
          //'redirect_uri': uri
        });
    return response;
  }
}
