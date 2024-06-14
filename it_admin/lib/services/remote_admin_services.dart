import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'api_client.dart';

class RemoteAdminServices {
  const RemoteAdminServices();
  final _apiClient = const ApiClient();

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

  Future<http.Response> getFile(String directory, String name) async {
    var response = await _apiClient.getRequest(
      path: '/files/$directory/$name',
      file: true,
    );
    log(response.body);
    return response;
  }

  Future<http.Response> addFile(List<int> bytes, String name) async {
    final url = Uri.parse('${ApiClient.fileIp}/files');
    final request = http.MultipartRequest("POST", url);
    request.files.add(
      http.MultipartFile.fromBytes(
        'markdown',
        bytes,
        filename: name,
        contentType: MediaType('text', 'markdown'),
      ),
    );
    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);
    log(response.body);
    return response;
  }

  Future<http.Response> addFileToDir(
      String directory, List<int> bytes, String name) async {
    final url = Uri.parse('${ApiClient.fileIp}/files/$directory');
    final request = http.MultipartRequest("POST", url);
    request.files.add(
      http.MultipartFile.fromBytes(
        'markdown',
        bytes,
        filename: name,
        contentType: MediaType('text', 'markdown'),
      ),
    );
    final responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);
    log(response.body);
    return response;
  }

  Future<http.Response> getUserInfo(String email) async {
    var response = await _apiClient.getRequest(
      path: '/users/$email',
    );
    log(response.body);
    return response;
  }

  Future<http.Response> getUsers(String fullName, int page, int size) async {
    var path = '/users?';
    if (fullName != '') {
      path += 'fullName=$fullName';
      if (page != -1) {
        path += '&page=$page';
        if (size != -1) {
          path += '&size=$size';
        }
      }
      if (size != -1) {
        path += '&size=$size';
      }
    } else if (page != -1) {
      path += '&page=$page';
      if (size != -1) {
        path += '&size=$size';
      }
    } else if (size != -1) {
      path += '&size=$size';
    }
    var response = await _apiClient.getRequest(
      path: path,
    );
    log(response.body);
    return response;
  }

  Future<http.Response> editInfo(
    int userId,
    String name,
    String surname,
    String patronymic,
    String email,
  ) async {
    var response = await _apiClient.request(
      path: '/users/$userId',
      reqType: 'patch',
      body: {
        "name": name,
        "surname": surname,
        "patronymic": patronymic,
        "email": email
      },
    );
    log(response.body);
    return response;
  }

  Future<http.Response> getUniqueCompetencies() async {
    var response = await _apiClient.getRequest(
      path: '/competencies/unique-names',
    );
    log(response.body);
    return response;
  }

  Future<http.Response> getCompetencies(String name, int page, int size) async {
    var path = '/competencies?';
    if (name != '') {
      path += 'name=$name';
      if (page != -1) {
        path += '&page=$page';
        if (size != -1) {
          path += '&size=$size';
        }
      }
      if (size != -1) {
        path += '&size=$size';
      }
    } else if (page != -1) {
      path += '&page=$page';
      if (size != -1) {
        path += '&size=$size';
      }
    } else if (size != -1) {
      path += '&size=$size';
    }
    var response = await _apiClient.getRequest(
      path: path,
    );
    log(response.body);
    return response;
  }

  Future<http.Response> getCompetencyById(int id) async {
    var response = await _apiClient.getRequest(
      path: '/competencies/$id',
    );
    log(response.body);
    return response;
  }

  Future<http.Response> editCompetency(int id, String name, int priority,
      String level, int testTime, int pass) async {
    var response = await _apiClient.request(
        path: '/competencies/$id',
        body: {
          "name": name,
          "priority": priority,
          "level": level,
          "testTimeMinutes": testTime,
          "passThreshold": pass
        },
        reqType: 'patch');
    log(response.body);
    return response;
  }

  Future<http.Response> addCompetency(String name, int priority, String level,
      int testTime, int pass, List<Map> skills, List<Map> questions) async {
    var response = await _apiClient.request(
        path: '/competencies',
        body: {
          "name": name,
          "priority": priority,
          "level": level,
          "testTimeMinutes": testTime,
          "passThreshold": pass,
          "skills": skills,
          "questions": questions,
        },
        reqType: 'post');
    log(response.body);
    return response;
  }

  Future<http.Response> addTestQuestions(int id, List<Map> questions) async {
    var response = await _apiClient.request(
        path: '/competencies/$id/test-questions',
        body: {questions},
        reqType: 'post');
    log(response.body);
    return response;
  }

  Future<http.Response> editQuestions(
      int id, int qId, String desc, List<Map> answerOptions) async {
    var response = await _apiClient.request(
        path: '/competencies/$id/test-questions/$qId',
        body: {
          "description": desc,
          "answerOptions": answerOptions,
        },
        reqType: 'patch');
    log(response.body);
    return response;
  }

  Future<http.Response> addSkill(
      int id, String name, List<String> markdowns) async {
    var response = await _apiClient.request(
        path: '/competencies/$id/skills',
        body: {
          [
            {
              "name": name,
              "markdowns": markdowns,
            }
          ]
        },
        reqType: 'put');
    log(response.body);
    return response;
  }

  Future<http.Response> deleteComp(int id) async {
    var response =
        await _apiClient.request(path: '/competencies/$id', reqType: 'delete');
    log(response.body);
    return response;
  }

  Future<http.Response> deleteSkill(int id, int skillId) async {
    var response = await _apiClient.request(
        path: '/competencies/$id/skills/$skillId', reqType: 'delete');
    log(response.body);
    return response;
  }

  Future<http.Response> deleteQuestion(int id, int qId) async {
    var response = await _apiClient.request(
        path: '/competencies/$id/test-questions/$qId', reqType: 'delete');
    log(response.body);
    return response;
  }
}
