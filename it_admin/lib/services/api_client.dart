import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiClient {
  static const ip = 'http://192.168.31.93:8001/api';
  static const fileIp = 'http://192.168.31.93:8002/api';
  static const auth = 'http://192.168.31.93:8004/api';
  static final client = http.Client();
  const ApiClient();

  Future<http.Response> getRequest({
    required String path,
    bool addIp = true,
    bool authIp = false,
    bool file = false,
  }) async {
    try {
      final url = authIp
          ? Uri.parse((addIp ? auth : '') + path)
          : file
              ? Uri.parse(fileIp + path)
              : Uri.parse((addIp ? ip : '') + path);
      final response = await client.get(url);
      log(authIp ? (addIp ? auth : '') + path : (addIp ? ip : '') + path);
      if (response.body.length < 10000) {
        // log(response.body);
      } else {
        //log(response.body.substring(0, 2000));
      }
      log(response.request.toString());

      switch (response.statusCode) {
        case 200:
          return response;
        default:
          throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> request({
    required String path,
    required String reqType,
    Object? body,
    bool addIp = true,
    bool authIp = false,
  }) async {
    final url = authIp
        ? Uri.parse((addIp ? auth : '') + path)
        : Uri.parse((addIp ? ip : '') + path);
    http.Response response;
    switch (reqType) {
      case 'post':
        {
          response = await client.post(
            url,
            body: body,
          );
        }
      case 'patch':
        {
          response = await client.patch(
            url,
            body: body,
          );
        }
      case 'put':
        {
          response = await client.put(
            url,
            body: body,
          );
        }
      default:
        {
          response = await client.delete(
            url,
            body: body,
          );
        }
    }
    log(authIp ? auth + path : ip + path);
    log(response.body);
    log(response.request.toString());
    switch (response.statusCode) {
      case 200:
        return response;
      default:
        throw Exception(response.reasonPhrase);
    }
  }

  // Future<http.Response> postRequest({
  //   required String path,
  //   Object? body,
  //   bool addIp = true,
  //   bool authIp = false,
  // }) async {
  //   final url = authIp
  //       ? Uri.parse((addIp ? auth : '') + path)
  //       : Uri.parse((addIp ? ip : '') + path);
  //   // try {
  //   var response = await client.post(
  //     url,
  //     body: body,
  //   );
  //   log(authIp ? auth + path : ip + path);
  //   log(response.body);
  //   log(response.request.toString());
  //   switch (response.statusCode) {
  //     case 200:
  //       return response;
  //     default:
  //       throw Exception(response.reasonPhrase);
  //   }
  //   // } catch (e) {
  //   //   throw Exception(e);
  //   // }
  // }

  Future<http.Response> postAuthRequest({
    required String path,
    Object? body,
    required String cookie,
    bool addIp = true,
  }) async {
    final url = Uri.parse((addIp ? auth : '') + path);
    Map<String, String> headers = {
      // 'Upgrade-Insecure-Requests': '1',
      // 'Origin': 'null',
      'content-Type': 'application/x-www-form-urlencoded',
      // 'User-Agent':
      //     'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Postman/10.24.26 Electron/20.3.11 Safari/537.36',
      // 'Accept':
      //     'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
      // 'Sec-Fetch-Site': 'same-origin',
      // 'Sec-Fetch-Mode': 'navigate',
      // 'Sec-Fetch-User': '?1',
      // 'Sec-Fetch-Dest': 'document',
      // 'Accept-Encoding': 'gzip, deflate, br',
      // 'Accept-Language': 'ru',
      'cookie': cookie
    };
    // try {
    var response = await client.post(
      url,
      body: body,
      headers: headers,
    );
    // log(auth + path);
    // log(response.body);
    // log(response.request.toString());
    switch (response.statusCode) {
      case 200:
        return response;
      case 302:
        return response;
      default:
        throw Exception(response.reasonPhrase);
    }
    // } catch (e) {
    //   throw Exception(e);
    // }
  }

  Future<http.Response> postTokenRequest({
    required String path,
    required String encoded,
    Object? body,
    bool addIp = true,
  }) async {
    final url = Uri.parse((addIp ? auth : '') + path);
    Map<String, String> headers = {
      'content-Type': 'application/x-www-form-urlencoded',
      'authorization': 'Basic $encoded',
      // 'User-Agent':
      //     'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Postman/10.24.26 Electron/20.3.11 Safari/537.36',
      // 'Accept': '*/*',
      // 'Cache-Control': 'no-cache',
      'host': '192.168.31.93:8004',
      // 'Sec-Fetch-User': '?1',
      // 'Sec-Fetch-Dest': 'document',
      // 'Accept-Encoding': 'gzip, deflate, br',
      // 'Connection': 'keep-alive'/,
      'content-Length': '85' //'188'
    };
    // try {
    var response = await client.post(
      url,
      body: body,
      headers: headers,
      encoding: Encoding.getByName('utf-8'),
    );
    log(auth + path);
    log(response.body);
    log(response.headers.toString());
    log(response.request.toString());
    switch (response.statusCode) {
      case 200:
        return response;
      default:
        throw Exception(response.reasonPhrase);
    }
    // } catch (e) {
    //   throw Exception(e);
    // }
  }

  // Future<http.Response> patchRequest(
  //     {required String path, Object? body, bool addIp = true}) async {
  //   final url = Uri.parse((addIp ? ip : '') + path);
  //   // try {
  //   var response = await client.patch(
  //     url,
  //     body: body,
  //   );
  //   log(ip + path);
  //   log(response.body);
  //   log(response.request.toString());
  //   switch (response.statusCode) {
  //     case 200:
  //       return response;
  //     default:
  //       throw Exception(response.reasonPhrase);
  //   }
  //   // } catch (e) {
  //   //   throw Exception(e);
  //   // }
  // }

  // Future<http.Response> putRequest(
  //     {required String path, Object? body, bool addIp = true}) async {
  //   final url = Uri.parse((addIp ? ip : '') + path);
  //   // try {
  //   var response = await client.put(
  //     url,
  //     body: body,
  //   );
  //   log(ip + path);
  //   log(response.body);
  //   log(response.request.toString());
  //   switch (response.statusCode) {
  //     case 200:
  //       return response;
  //     default:
  //       throw Exception(response.reasonPhrase);
  //   }
  //   // } catch (e) {
  //   //   throw Exception(e);
  //   // }
  // }

  // Future<http.Response> deleteRequest(
  //     {required String path, Object? body, bool addIp = true}) async {
  //   final url = Uri.parse((addIp ? ip : '') + path);
  //   // try {
  //   var response = await client.delete(
  //     url,
  //     body: body,
  //   );
  //   log(ip + path);
  //   log(response.body);
  //   log(response.request.toString());
  //   switch (response.statusCode) {
  //     case 200:
  //       return response;
  //     default:
  //       throw Exception(response.reasonPhrase);
  //   }
  //   // } catch (e) {
  //   //   throw Exception(e);
  //   // }
  // }
}
