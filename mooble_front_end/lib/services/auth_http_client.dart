import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/api_config.dart';

class AuthHttpClient {
  final _storage = const FlutterSecureStorage();

  /// GET request
  Future<http.Response> get(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    return _sendRequest(
      method: 'GET',
      path: path,
      queryParams: queryParams,
    );
  }

  /// POST request with optional queryParams and body.
  /// Use [sendAsJson] = false to send body as form-urlencoded.
  Future<http.Response> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
    bool sendAsJson = true,
  }) async {
    return _sendRequest(
      method: 'POST',
      path: path,
      body: body,
      queryParams: queryParams,
      sendAsJson: sendAsJson,
    );
  }

  /// PUT request
  Future<http.Response> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
    bool sendAsJson = true,
  }) async {
    return _sendRequest(
      method: 'PUT',
      path: path,
      body: body,
      queryParams: queryParams,
      sendAsJson: sendAsJson,
    );
  }

  /// DELETE request
  Future<http.Response> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
    bool sendAsJson = true,
  }) async {
    return _sendRequest(
      method: 'DELETE',
      path: path,
      body: body,
      queryParams: queryParams,
      sendAsJson: sendAsJson,
    );
  }

  /// Core request handler with token refresh & retry
  Future<http.Response> _sendRequest({
    required String method,
    required String path,
    Map<String, String>? queryParams,
    Map<String, dynamic>? body,
    bool sendAsJson = true,
  }) async {
    String? token = await _getAccessToken();
    var uri = Uri.parse("${ApiConfig.baseUrl}$path").replace(queryParameters: queryParams);

    http.Response response = await _makeHttpCall(
      method: method,
      uri: uri,
      token: token,
      body: body,
      sendAsJson: sendAsJson,
    );

    // If unauthorized, try refreshing the token and retry once
    if (response.statusCode == 401) {
      bool refreshed = await _refreshToken();
      if (refreshed) {
        token = await _getAccessToken();
        response = await _makeHttpCall(
          method: method,
          uri: uri,
          token: token,
          body: body,
          sendAsJson: sendAsJson,
        );
      }
    }

    return response;
  }

  /// Makes the actual HTTP call
  Future<http.Response> _makeHttpCall({
    required String method,
    required Uri uri,
    required String? token,
    Map<String, dynamic>? body,
    bool sendAsJson = true,
  }) async {
    Map<String, String> headers = _authHeaders(token);

    if (!sendAsJson) {
      // For sending body as form-url-encoded instead of JSON
      headers['Content-Type'] = 'application/x-www-form-urlencoded';
    }

    switch (method) {
      case 'GET':
        return http.get(uri, headers: headers);

      case 'POST':
        if (body == null) {
          return http.post(uri, headers: headers);
        }
        if (sendAsJson) {
          return http.post(uri, headers: headers, body: jsonEncode(body));
        } else {
          final formBody = body.entries
              .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
              .join('&');
          return http.post(uri, headers: headers, body: formBody);
        }

      case 'PUT':
        if (body == null) {
          return http.put(uri, headers: headers);
        }
        if (sendAsJson) {
          return http.put(uri, headers: headers, body: jsonEncode(body));
        } else {
          final formBody = body.entries
              .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
              .join('&');
          return http.put(uri, headers: headers, body: formBody);
        }

      case 'DELETE':
        if (body == null) {
          return http.delete(uri, headers: headers);
        }
        if (sendAsJson) {
          return http.delete(uri, headers: headers, body: jsonEncode(body));
        } else {
          final formBody = body.entries
              .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
              .join('&');
          return http.delete(uri, headers: headers, body: formBody);
        }

      default:
        throw Exception("Unsupported HTTP method: $method");
    }
  }

  /// Refresh the access token using the refresh token
  Future<bool> _refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    if (refreshToken == null) return false;

    try {
      final uri = Uri.parse("${ApiConfig.baseUrl}/auth/refresh-token");
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'refreshToken': refreshToken}));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _storage.write(key: 'accessToken', value: data['accessToken']);
        await _storage.write(key: 'refreshToken', value: data['refreshToken']);
        return true;
      }
    } catch (_) {}

    return false;
  }

  /// Get access token from storage
  Future<String?> _getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  /// Common authorization headers
  Map<String, String> _authHeaders(String? token) {
    return {
      if (token != null) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}