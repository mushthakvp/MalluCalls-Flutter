import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Server {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const int _timeout = 120;

  /// Get request

  static Future<List> get(String url) async {
    String? token = await _storage.read(key: "token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "authorization": "Bearer $token",
    };
    try {
      // log("token: $token");
      var response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: _timeout));
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  /// Post request

  static Future<List> post(String url, {Map<String, dynamic>? data}) async {
    String? token = await _storage.read(key: "token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "authorization": "Bearer $token",
    };
    try {
      var body = json.encode(data);
      var response = await http
          .post(
            Uri.parse(url),
            body: body,
            headers: headers,
          )
          .timeout(const Duration(seconds: _timeout));
      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [555, e.toString()];
    }
  }

  /// Put request

  static Future<List> put(
    String url, {
    Map<String, dynamic>? data,
    bool isData = false,
  }) async {
    String? token = await _storage.read(key: "token");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "authorization": "Bearer $token",
    };
    try {
      var body = json.encode(data);

      var response = await http
          .put(
            Uri.parse(url),
            body: isData ? null : body,
            headers: headers,
          )
          .timeout(const Duration(seconds: _timeout));

      return _response(response);
    } on SocketException {
      return [600, "No internet"];
    } catch (e) {
      return [600, e.toString()];
    }
  }

  // ------------------- ERROR HANDLING ------------------- \\

  static List _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return [response.statusCode, jsonDecode(response.body)];
      case 201:
        return [response.statusCode, jsonDecode(response.body)];
      case 400:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 401:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 403:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 404:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 500:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      default:
        return [response.statusCode, jsonDecode(response.body)["message"]];
    }
  }
}
